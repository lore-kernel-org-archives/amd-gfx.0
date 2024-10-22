Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DBCD1CDB8
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 08:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C230C10E621;
	Tue, 22 Oct 2024 08:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NBc77T7r";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D18010E621
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 08:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E14GGpewHbqwWKkNoPlzKxlVS7SgSPp4UB1B0oBDtGkZSfAnT8w25hemYtS7e5BGUOU8IN+UCM9qXkakmM1ixQstSFJkyio34bvRKTVZKRaBvpRb1s/PkYKHsSeVeHPh4e2AYSDqi1N799Ino0UhG2YxA8w3Gw3AQQh8L4CDXl/caI9ZjIwY8d4GL5nDSAjr39yeLRGQNEy9j852Vf78l7VwQdvibHcv6GdvXYdkEEkr2ZE3JP4qmbjkez2L7S3M5Lfjlk/UxaVl1lffFwNkiB8Z29fBAlSp4SJoJsHSmzW6nhgcFew++9gE6HpSmtFy/zHG22xX1DYfIB8dwAfU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUFpjlVnoaGHeoZ2MUzUOfAIQJo2dj0iHrZWB4Tn/cw=;
 b=Z+sRX/kvSPdBFXuAca119VrPmRN7AuSMS91Uv8txf3AHYxMJH8kB5Wt2EWoH4ldVNIH01o4fGT+5hURAj0SX/oA64EbPJn8UGFXaDv/rLpaabCXVmG+xd6UMbL+7xwRtAgpo9vqJMttn1fWa3+lD+ZWTx2A4lrf6OkIL3Oi/1Hd0Rqrr41Sv/bUy8wdEQQoyyc2GLx7uC+DUbKF1fZsPP1uXViwEhwPG0e9AIwyoyRfxNe8cJMAtwKpWtmrdycttUiWHomOROODaKliuMmxR+DoS57L1Msq1A97SO4ZKSjqsOA6/5f7BjP7lBQUmqVtUBOpb7lPKEfIkDePGh0DxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUFpjlVnoaGHeoZ2MUzUOfAIQJo2dj0iHrZWB4Tn/cw=;
 b=NBc77T7r94yMX83myVqALlJDQh7XWHWprSwt1roqVUsXiBmG7aBCLNMe76jggtLmu5Gt3zd4BKpoiXdv0G55QsomYsbMQ6fs4D+U/HRdof5Sm6qIsLaYVHhwY55ctgl2w3/Ht2fvjb570Mtu0eXOh3LyMJrkIjIDMznaG2XKTJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Tue, 22 Oct
 2024 08:57:08 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:57:07 +0000
Subject: Re: [PATCH 29/32] drm/amdgpu: dump_ip_state for each vcn instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
 <20241017132053.53214-30-boyuan.zhang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <13fb4b4c-7a32-a336-8e37-8d95c72552b7@amd.com>
Date: Tue, 22 Oct 2024 14:26:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241017132053.53214-30-boyuan.zhang@amd.com>
Content-Type: multipart/alternative;
 boundary="------------4C5F84CC0B20AE4739C06595"
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d87a4c5-2ea8-4cb4-92f1-08dcf27781c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXQ3OEZ5VUtVT2FoZEFQYW5qaGMrK0o4SHRSMnpETmxtMmNpQ3VOMXRWenZU?=
 =?utf-8?B?ektQdTBsamlaQlp3VHdKbjk2RWI5Sis5S0Zpd1lwM3dCMkhsU1VVMk90RWpN?=
 =?utf-8?B?Z1poSFRVa296Zmc0cVVqWlZhVVJkV09hb0R4YXgwaFRvUzNCZ09paW13Mmt1?=
 =?utf-8?B?TGRJVEFjVzlGcTYyK2tRZWM5R2h0SlNzWVd4MFg2Z2ZPSzRYWHJYdWhpL0NF?=
 =?utf-8?B?ODd4UmhjL2JhYkxLQnBIMFJlMkkzVkJFanE2K0ZGZWVWUG43R0dpWHdkbzRH?=
 =?utf-8?B?UU5LUm9QQ0JHclB3MzR5SURDcVByMjU4MGZXMXdkTXQxbmxXZjZmaU81TTEr?=
 =?utf-8?B?Ly9BcnhMbEp0Ty9oVGxqOEJjRy9qME41Vml6cDBUS1BxRXdDcmE4N0IvbEZH?=
 =?utf-8?B?YW9TeXpVNmp3eHFMN0NsY25kVFRVZXFNNzRrZkZ3Q1owTXUrQ2NlL0dWSU1r?=
 =?utf-8?B?dEFxNzNxYVNQcUJmcWNCK1pxcEJza1RXK0R5VFl2cE1qSnF6a01xcm8xbFdx?=
 =?utf-8?B?c1pLcDZmRWZlWDBLdFREM3RBR3pGU1EwRTN1WHJOMk0zZUFqNUF6eWJlSXB1?=
 =?utf-8?B?OWFjdzJ0Y3VyT2FMNFJSSy9qWXZsNDVBRHdWTXFuVm5BNjhHWjRBd1l4QThZ?=
 =?utf-8?B?M1hHbzZCd1pKa0JmQi9oUUMraHJZRGRqcVZXMmFrWEg2dFR3SnpGZlB2cllN?=
 =?utf-8?B?Qy9rRkMzOWVQTDJjb05TbXNsOUJCYlBjNFVhUjc3OGpCY2ZmTHRaYUMvTXlJ?=
 =?utf-8?B?NE5RRTQ0SjVSWXRTakhHcEE1bXl5QzYxaUl5RmtvalZhcHVYek5IMnUxL2Nt?=
 =?utf-8?B?eCtzNkhOTHFVNEN5aGtGODZpTHZwRVgrVFYxSDUzekpLLzVGYm1iWmJsRmhl?=
 =?utf-8?B?aU5RQ1FGY2VNWUkxNllXdnNuQUoxRzcwQk0ya0UwVy94eER5V291NElNNFFB?=
 =?utf-8?B?SzlEd0tmbGlzWnMzUzRuS2laOW5zN1JyaGViUko4b2FZZVB5Y1l5d1hzV1JI?=
 =?utf-8?B?L1liMFV1czVtcW9TUldLWlRlTTlDRE5HbXJhN1FTTEhYam5KRCtzRGdrRzNp?=
 =?utf-8?B?Y2lqUDQwQk40M2x6b0JjSEFZcXFtVHBxWE1BM1J6TmthazhUendza3FTeTh5?=
 =?utf-8?B?c1FrSVI4eVlPTWJBSzlXbDFzY2o0dk9OODhQcnNVb0dSbnpBcE5zdTNPQ1Nz?=
 =?utf-8?B?R29hTU9leFNNVXNyMFJkcXFPcyt5VjNuTDg3b05NN2RPZ3R1TG9YcDJGUm9l?=
 =?utf-8?B?OGlRMGJ4SmdDYld4d0RMdnphUUtlYy9TSng4UnVJSkhaVWlzN05LM2Z0OG95?=
 =?utf-8?B?TXB3NGdTMmMzZm5QZW53VCtQNzY3YjlzMklxL01GbUJrQUJVajNSclhnZ2Vl?=
 =?utf-8?B?Uk9zbnJtWXdSMHNvUzJZS2ZYVEF5R0dnQkZmWXBrYmZ0WGZLQWJiN3hRcmNF?=
 =?utf-8?B?aW5hSEp1cC9FdkJZZFNDcDdod0s4dG1tcVJhV0c4SUZHSElzQ1BKZEFVckp4?=
 =?utf-8?B?aVFrVEprVi84Mk5UcVh2ZzFSMG1KOG9DWEZ4Z1ZNdnlGVElJNnl1d0pjUTlK?=
 =?utf-8?B?Ym5KR3NuenI5R1BQRnFlU3l6aTJMMnZaSkt1TXExVmY0Q1hLbHRYOStNUy8w?=
 =?utf-8?B?MlBscGwzbVU5N1k1MlNBYzRnSFFPaWZydDlOaXpsbEo0by9iZnc5SytXZ0Ew?=
 =?utf-8?B?VDVWZ2Y0RTJ1b3JnRlNkY0o4cGZ4T2tqVXZpKzVaR3orcW1KMjRpZ2x0SG9T?=
 =?utf-8?Q?7Jdh19wg1ElVqn5BbM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU40ODhVSzhWWHVaRDYzR0NnSkRUbnV5TmliVWVaU1pXMmpuK2Z3MXNFVncr?=
 =?utf-8?B?LzJSNS9Bc3k1bnlYWkduKzNUa0pjc3VCcG4vNEtVSi9zWFNYQ0FFRXo2MW9y?=
 =?utf-8?B?NmFhbTExeWhEeVMyYTZOaElPaGxwSzFGbGJ5a3dwQXgrNDM1U3RMOG9NSzNu?=
 =?utf-8?B?TFNsaWNoOEFmY0taVlNESTdsZlkxQ2YvSnp4QkFiQ3EveXV0cEp4ekNqVjRm?=
 =?utf-8?B?NzZiaThpZEJBMGFCSFJaZDI3TFBtcERLczUzelA4ei85akhjYzl3am5qWHNB?=
 =?utf-8?B?R3BoTEVUK3d6UXBQMXlrNTd2aDdYVTZrak1qQi85NjZwekdzM3psc3h0ckor?=
 =?utf-8?B?VERSL1lTRFZzL2Y3RkxacXBDOGw0MDh5Q2NOVmQ5aVZJOTh5Uy9uTzBzN1dE?=
 =?utf-8?B?YWxuTE84SmxvclBTTUFMYU9MclVsbEFwcGExTVNJVmhrUERrQkxqSFpvVFVU?=
 =?utf-8?B?dUR5ZCtWVGhxdHlDQ3ZpdkhMK0RNZVd0NnhIWkdQcGFBSCt2bklmaUtYNkVT?=
 =?utf-8?B?OUZETWZ0QmNwUTVwbGhNTU1qYjZVamJDWlhTMFRmTDJIakxWQVBSZkp0aHBa?=
 =?utf-8?B?eU0ySEl5V2MrUkI1SDJ4eXk1d1I1WEgxZktUNDY4dVdabGtJR294NFAwNm9u?=
 =?utf-8?B?T3JMQmUxUmNMWHlWb0lLUlVsUVV6aVVLWDBzc1AvUWxCTjFqUU9QTzU3OHRt?=
 =?utf-8?B?alZPY0JnZHd1cHhicFVZcXJTZms0OFU1QXk2Tlg4M3JFODBJVFVBcTd1WDcr?=
 =?utf-8?B?TzVuZ0NZV09peUVkME83am5uejVxVE01cWRwTGMwaVJkNkRUdUdVK3dvZDZW?=
 =?utf-8?B?OUNSeGM0RVN1S2M0aGhUZVZFNFBwUWJuQVBXTFRuTE9sMSt4MkRBQzNDM0d3?=
 =?utf-8?B?cUova05mRHZZYVpGK054bzYwL1VaSGVIcmV6V2Y0UGE1WWRaTkdXY2E0ZFNV?=
 =?utf-8?B?bi91ZVNzZDAydmVUSnNaNkMwME9pWUt5SnJsT3JvdDQ3aW5CcWFSanRBQVhT?=
 =?utf-8?B?cU5ZMFlnOXVoT1N0c3NNTzV5YVBDL2FjaVg1UXNvK0tqWUhrUzZOMkxkOXI5?=
 =?utf-8?B?UDJDTFBtak9KbnFUaDlLQVIwcTJnQURvTm1hMTAzQXhzZGxlcllyZFdXUDdl?=
 =?utf-8?B?QWFkMDkvL1pZRlNIR2NkTHV2Z3ZEY0VqTmgvZGdrU0FNRW00WVNHaUNkd2ll?=
 =?utf-8?B?elRtOXZ0RjRiUHRPUS9WNzREUUQvKzBIY0VYZmpMYmNYdVBhVkJIblowSlM3?=
 =?utf-8?B?WTJsMSt4YnN3bHV0c01kdmRQampMSUFjTVJHeXJnVjMxWEo5VmlqUmo1cG1N?=
 =?utf-8?B?SkphdGl2Z1JvdGpkaUJnNnJnNE9hT3ZFMWxqdGJwM3NoTnhUeDNTZnZTdnhN?=
 =?utf-8?B?TFk5MWZ6N2RCSVIwK3Nxck9lY3lzL0JQU2p5RXJBa2hCRjNsSkxmRGRLL00w?=
 =?utf-8?B?WlhwRithNUlDN2RsaGxCN0tHOFNGVWdRMEFxYkZpbitOa001djNNaTZwem9N?=
 =?utf-8?B?aFIzMnRRNUFzVkZ0QkpkWi9TNXA2ZVNKdTlTTXdzWUFzQ0prVkRsWCt2aVl5?=
 =?utf-8?B?NWticmdYdkcyMFhwdGIyMDA4cittSFc3MTU2K25kT0pqSWpZaXpadEtUTVBn?=
 =?utf-8?B?MFNoZEJiUUlxOTBSWjcwbmFucjZPem5GU2RiN3JjQ2FnaHVERTRnb2R4djM1?=
 =?utf-8?B?L3dGSlFOOHpCbEszSlUweFNaSnFIWXI5Nkk4MnpSU1VjR1lBYk90NVVRU0ZW?=
 =?utf-8?B?Z3lTZTdVTlZXOUpTQitZbmxscFRtMERZTFlrSjRXOEh6aUR5SHBDMEhvM09B?=
 =?utf-8?B?ZlNMa2RucTE2SDUra0x1UllicEpOemVNZ3JhM2ZnS0FaZ1BEazFuZzlFMFY0?=
 =?utf-8?B?TWY1U3lRcTMybVJJM0ZUenAxbDNxeSthdE9qdUxNVjE4cUprLzVjYmUvOGxI?=
 =?utf-8?B?Y2Uzd0xiMk5OUUVZZ01mVTkvdE9LME40Y0hXaVowd3phanJwSG0vTVdNL2Yw?=
 =?utf-8?B?bFRVUGdmSHpLN21hWVV5MXQ2ZjZtSzhERVB3eEF3Yk9hZk43WnRBb0xqYitC?=
 =?utf-8?B?bVpvazFhMkZzc1JqZnlaSExDRGdDU1gweUVGVjdmdjZ2bkQrUFh0d0QyUnJr?=
 =?utf-8?Q?5go1WDAeiHqUsOtK9zJJTDrEl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d87a4c5-2ea8-4cb4-92f1-08dcf27781c9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:57:07.5212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrUGQIQZ2e3eG6+CsQ9JO0R4S6gLhxTAzkiVkpU29Wgab2iedgT1htFt/YqZt72ICg63uobHyglTr8bGgzfHfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------4C5F84CC0B20AE4739C06595
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com 
<mailto:christian.koenig@amd.com>>

On 10/17/2024 6:50 PM, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Perform dump_ip_state only for the instance of the current vcn IP block,
> instead of perform it for all vcn instances.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 27 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 27 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 27 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 27 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 31 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 35 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 31 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 27 +++++++++----------
>   8 files changed, 112 insertions(+), 120 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 9255bcfc6c3d..27e0f206c9dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1964,7 +1964,8 @@ static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	bool is_powered;
>   	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
> @@ -1972,21 +1973,19 @@ static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
>   
> -		inst_off = i * reg_count;
> -		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered)
> -			for (j = 1; j < reg_count; j++)
> -				adev->vcn.ip_dump[inst_off + j] =
> -					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], i));
> -	}
> +	if (is_powered)
> +		for (j = 1; j < reg_count; j++)
> +			adev->vcn.ip_dump[inst_off + j] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], inst));
>   }
>   
>   static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 94f000ed4895..665b749c5ac0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -2072,7 +2072,8 @@ static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	bool is_powered;
>   	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
> @@ -2080,21 +2081,19 @@ static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
>   
> -		inst_off = i * reg_count;
> -		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered)
> -			for (j = 1; j < reg_count; j++)
> -				adev->vcn.ip_dump[inst_off + j] =
> -					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], i));
> -	}
> +	if (is_powered)
> +		for (j = 1; j < reg_count; j++)
> +			adev->vcn.ip_dump[inst_off + j] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], inst));
>   }
>   
>   static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 7c9a0169215e..5332b2903ce1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1946,7 +1946,8 @@ static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	bool is_powered;
>   	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
> @@ -1954,21 +1955,19 @@ static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
Since this for loop is removed which dump for each instances,clear my 
understanding here, there are multiple ip_blocks for vcn now and 
ip_block->instance is 0, 1, 2, 3 etc representing one instance ?
Assuming the use case of 2 instances so first time when 
vcn_v2_5_dump_ip_state is called it will comes with ip_block->instance = 
0 and then 1 and 2 in sequence as we are dumping that information in 
loop and storing in coredump in that sequence only.
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
>   
> -		inst_off = i * reg_count;
> -		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered)
> -			for (j = 1; j < reg_count; j++)
> -				adev->vcn.ip_dump[inst_off + j] =
> -					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], i));
> -	}
> +	if (is_powered)
> +		for (j = 1; j < reg_count; j++)
> +			adev->vcn.ip_dump[inst_off + j] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], inst));
> 	Storage we have linear to accomodate each vcn instance. So we need to make sure that when dump is called for instance sequentially we are adding values in vcn.ip_dump in same order so print should give right value else there could be a mismatch based on existing logic. Please try to cause a dump and hack around the code so is_powered is bypassed and we dump the values for each instance thats the only way to see if its working fine.
By looking at the code it seems it should work but there are some vcn 
variable which i am not so sure in new design.  Also patch for dump 
should come first and then print to reverse the order of 28 and 29 patch.
But testing is needed to make sure its working fine.
Regards
Sunil khatri
>   }
>   
>   static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 061c958700d8..40a3d29d4e71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -2269,7 +2269,8 @@ static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	bool is_powered;
>   	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
> @@ -2277,21 +2278,19 @@ static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
>   
> -		inst_off = i * reg_count;
> -		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered)
> -			for (j = 1; j < reg_count; j++)
> -				adev->vcn.ip_dump[inst_off + j] =
> -					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], i));
> -	}
> +	if (is_powered)
> +		for (j = 1; j < reg_count; j++)
> +			adev->vcn.ip_dump[inst_off + j] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], inst));
>   }
>   
>   static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index fdf346bf3e34..3b2f4f1e0939 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -2177,7 +2177,8 @@ static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	bool is_powered;
>   	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
> @@ -2185,22 +2186,20 @@ static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
>   
> -		inst_off = i * reg_count;
> -		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> -
> -		if (is_powered)
> -			for (j = 1; j < reg_count; j++)
> -				adev->vcn.ip_dump[inst_off + j] =
> -					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
> -									   i));
> -	}
> +	inst_off = inst * reg_count;
> +	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +
> +	if (is_powered)
> +		for (j = 1; j < reg_count; j++)
> +			adev->vcn.ip_dump[inst_off + j] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
> +								   inst));
>   }
>   
>   static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index daaf2fb6b3e5..be03d31cb206 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1757,7 +1757,8 @@ static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
>   static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	bool is_powered;
>   	uint32_t inst_off, inst_id;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
> @@ -1765,23 +1766,21 @@ static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -
> -		inst_id = GET_INST(VCN, i);
> -		inst_off = i * reg_count;
> -		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> -
> -		if (is_powered)
> -			for (j = 1; j < reg_count; j++)
> -				adev->vcn.ip_dump[inst_off + j] =
> -					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
> -									   inst_id));
> -	}
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
> +
> +	inst_id = GET_INST(VCN, inst);
> +	inst_off = inst * reg_count;
> +	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +
> +	if (is_powered)
> +		for (j = 1; j < reg_count; j++)
> +			adev->vcn.ip_dump[inst_off + j] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
> +								   inst_id));
>   }
>   
>   static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index ff8db22b9614..43b1f3d06157 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1638,7 +1638,8 @@ static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
>   static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	bool is_powered;
>   	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
> @@ -1646,22 +1647,20 @@ static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
>   
> -		inst_off = i * reg_count;
> -		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> -
> -		if (is_powered)
> -			for (j = 1; j < reg_count; j++)
> -				adev->vcn.ip_dump[inst_off + j] =
> -					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
> -									   i));
> -	}
> +	inst_off = inst * reg_count;
> +	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +
> +	if (is_powered)
> +		for (j = 1; j < reg_count; j++)
> +			adev->vcn.ip_dump[inst_off + j] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
> +								   inst));
>   }
>   
>   static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index c83a5c09f410..65554c4e86cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1365,7 +1365,8 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
>   static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int inst = ip_block->instance;
> +	int j;
>   	bool is_powered;
>   	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
> @@ -1373,21 +1374,19 @@ static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   	if (!adev->vcn.ip_dump)
>   		return;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
>   
> -		inst_off = i * reg_count;
> -		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	inst_off = inst * reg_count;
> +	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
> +	is_powered = (adev->vcn.ip_dump[inst_off] &
> +			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered)
> -			for (j = 1; j < reg_count; j++)
> -				adev->vcn.ip_dump[inst_off + j] =
> -					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], i));
> -	}
> +	if (is_powered)
> +		for (j = 1; j < reg_count; j++)
> +			adev->vcn.ip_dump[inst_off + j] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], inst));
>   }
>   
>   static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {

--------------4C5F84CC0B20AE4739C06595
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p>Reviewed-by: Sunil Khatri &lt;<a href="mailto:christian.koenig@amd.com">sunil.khatri@amd.com</a>&gt;</p>
    <div class="moz-cite-prefix">On 10/17/2024 6:50 PM,
      <a class="moz-txt-link-abbreviated" href="mailto:boyuan.zhang@amd.com">boyuan.zhang@amd.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241017132053.53214-30-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>

Perform dump_ip_state only for the instance of the current vcn IP block,
instead of perform it for all vcn instances.

Signed-off-by: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 31 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 35 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 31 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 27 +++++++++----------
 8 files changed, 112 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 9255bcfc6c3d..27e0f206c9dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1964,7 +1964,8 @@ static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
@@ -1972,21 +1973,19 @@ static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev-&gt;vcn.ip_dump)
 		return;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j &lt; reg_count; j++)
-				adev-&gt;vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j &lt; reg_count; j++)
+			adev-&gt;vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 94f000ed4895..665b749c5ac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2072,7 +2072,8 @@ static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
@@ -2080,21 +2081,19 @@ static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev-&gt;vcn.ip_dump)
 		return;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j &lt; reg_count; j++)
-				adev-&gt;vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j &lt; reg_count; j++)
+			adev-&gt;vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 7c9a0169215e..5332b2903ce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1946,7 +1946,8 @@ static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
@@ -1954,21 +1955,19 @@ static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev-&gt;vcn.ip_dump)
 		return;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;</pre>
    </blockquote>
    Since this for loop is removed which dump for each instances,clear
    my understanding here, there are multiple ip_blocks for vcn now and
    ip_block-&gt;instance is 0, 1, 2, 3 etc representing one instance ?<br>
    Assuming the use case of 2 instances so first time when
    vcn_v2_5_dump_ip_state is called it will comes with
    ip_block-&gt;instance = 0 and then 1 and 2 in sequence as we are
    dumping that information in loop and storing in coredump in that
    sequence only. <br>
    <blockquote type="cite" cite="mid:20241017132053.53214-30-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j &lt; reg_count; j++)
-				adev-&gt;vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j &lt; reg_count; j++)
+			adev-&gt;vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], inst));
	Storage we have linear to accomodate each vcn instance. So we need to make sure that when dump is called for instance sequentially we are adding values in vcn.ip_dump in same order so print should give right value else there could be a mismatch based on existing logic. Please try to cause a dump and hack around the code so is_powered is bypassed and we dump the values for each instance thats the only way to see if its working fine.</pre>
    </blockquote>
    By looking at the code it seems it should work but there are some
    vcn variable which i am not so sure in new design.&nbsp; Also patch for
    dump should come first and then print to reverse the order of 28 and
    29 patch.<br>
    But testing is needed to make sure its working fine.<br>
    Regards<br>
    Sunil khatri<br>
    <blockquote type="cite" cite="mid:20241017132053.53214-30-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">
 }
 
 static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 061c958700d8..40a3d29d4e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2269,7 +2269,8 @@ static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
@@ -2277,21 +2278,19 @@ static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev-&gt;vcn.ip_dump)
 		return;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j &lt; reg_count; j++)
-				adev-&gt;vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j &lt; reg_count; j++)
+			adev-&gt;vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fdf346bf3e34..3b2f4f1e0939 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2177,7 +2177,8 @@ static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
@@ -2185,22 +2186,20 @@ static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev-&gt;vcn.ip_dump)
 		return;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j &lt; reg_count; j++)
-				adev-&gt;vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
-									   i));
-	}
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+	if (is_powered)
+		for (j = 1; j &lt; reg_count; j++)
+			adev-&gt;vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
+								   inst));
 }
 
 static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index daaf2fb6b3e5..be03d31cb206 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1757,7 +1757,8 @@ static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off, inst_id;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
@@ -1765,23 +1766,21 @@ static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev-&gt;vcn.ip_dump)
 		return;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
-
-		inst_id = GET_INST(VCN, i);
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j &lt; reg_count; j++)
-				adev-&gt;vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
-									   inst_id));
-	}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		return;
+
+	inst_id = GET_INST(VCN, inst);
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+	if (is_powered)
+		for (j = 1; j &lt; reg_count; j++)
+			adev-&gt;vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
+								   inst_id));
 }
 
 static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ff8db22b9614..43b1f3d06157 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1638,7 +1638,8 @@ static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
@@ -1646,22 +1647,20 @@ static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev-&gt;vcn.ip_dump)
 		return;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j &lt; reg_count; j++)
-				adev-&gt;vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
-									   i));
-	}
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+	if (is_powered)
+		for (j = 1; j &lt; reg_count; j++)
+			adev-&gt;vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
+								   inst));
 }
 
 static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c83a5c09f410..65554c4e86cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1365,7 +1365,8 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i, j;
+	int inst = ip_block-&gt;instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
@@ -1373,21 +1374,19 @@ static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev-&gt;vcn.ip_dump)
 		return;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j &lt; reg_count; j++)
-				adev-&gt;vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j &lt; reg_count; j++)
+			adev-&gt;vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
</pre>
    </blockquote>
  </body>
</html>

--------------4C5F84CC0B20AE4739C06595--
