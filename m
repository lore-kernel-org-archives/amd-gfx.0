Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDDDC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0572110E129;
	Thu, 10 Apr 2025 13:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SZutbTgN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188A610E129
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 13:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XChAwZzfHXO9cUwpmWU/OkBmCUxFs0dSzIQKpUjv3lQLOiZw15uJVi4NOm0iKtIxPP6RVtQYa8CMPNZQ42A1nsw1wy/E1VR4qMwL2ThtXpqfdOM4Y45KZ+Xt0FGlX0Z7VmSERp9oZdAjFp1PeLhEVB+KFWhbikkLGt8AELxzQqtCyMtS5KsQL8u5ROlneajNRBvrLlJEkwAHr6QNS0/xgSBU5STx2Szx+Zw6jGslAmVx3i38sfRM+C7hcBgDgS4zr4xOD6Jlj2Q2u0Oa+O2ZnvWqbu9AT9UNaEVRXOQtpcUSxMZk9M/kEHioc0z0qak8eKAvcm2N6RCDMDtSqmXClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3KRzRh4FvriQAt/kGrtoZQBuyfHQify94tR6oBLyy4=;
 b=NdIkeG+Zt8rUYAVp2u9Z76koCJbIFcN7ztEk70ZD2rFUiHZ1yTIyklsf/hEE0Jp65s7NtDQ4HxOa0NYi1ugKXlnRzKg0T71o7ZJldkBmR+YoU/nMNUR/M0QtYHeO/YEEEqnpRUa18+evokphkQZuhahuUQFhZFzOMRvTybQCGI+05GU4gBVRar3INwo7QQGK493LhEFK8mpA38W0YoVVHcMfCXOUFN3ydiCxWNkSHmxJhqB33nZEOAlRHKeyu1Pvv50396Tqgj8F4jg+Ydfc6u+NtlswAXDaA4wu3GhQRuKyG5BNhkISGjT6JOpvzTnaJEkEhIctnDb/mj/RASusug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3KRzRh4FvriQAt/kGrtoZQBuyfHQify94tR6oBLyy4=;
 b=SZutbTgNSYo16Z+b8Yil5Jq/E9ONKNFdx/iT/JxTVx5eEs/C5rvub6qLuqu6cHfIy94WRbhstsvRpEJxsjyxU8ZFI9y0m3bi/PPI3HeqfAha+W+sIVmEuEOD8FMMSCiJs/37ObNfMjERxwxgHbI48SXfQqTh6LY98qjrFipK4xY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 13:55:33 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.024; Thu, 10 Apr 2025
 13:55:33 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Add fw minimum version check for usermode
 queue
To: Alex Deucher <alexdeucher@gmail.com>, Arvind Yadav <Arvind.Yadav@amd.com>
Cc: Christian.Koenig@amd.com, alexander.deucher@amd.com,
 sunil.khatri@amd.com, shashank.sharma@amd.com, amd-gfx@lists.freedesktop.org
References: <20250410112917.13725-1-Arvind.Yadav@amd.com>
 <20250410112917.13725-2-Arvind.Yadav@amd.com>
 <CADnq5_MGxCYfWBQspJTeUkmNj0X=jtneh1jz6AJZNDAB03Dh5g@mail.gmail.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <1662cae4-df08-4b00-0c25-b33cda0a48bd@amd.com>
Date: Thu, 10 Apr 2025 19:25:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CADnq5_MGxCYfWBQspJTeUkmNj0X=jtneh1jz6AJZNDAB03Dh5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN4PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::9) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bd5e24-139a-4ff4-6d95-08dd78375c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGFlL01NWmR2SHlEMnExbHA5TGdYcFBzYk1zUnU3cUNTMGM3dE9CTXlqSXBQ?=
 =?utf-8?B?eml6Wm5LTVJrWGJxOHZPSUE2dklpYWV2NHZ4YitEWk5Uank4RVZmci9zbWFD?=
 =?utf-8?B?Wjd5d2JVMTN5bmh5bXZhNzBzaUpYa1lWOSt2T0FkcUZsbzlBYm1uRCszMXMx?=
 =?utf-8?B?UVZNVldzMzVnYXRLbit4Z2FMUitYN3l3NzVWdmQyL25SMmdWRGUrbUVrK3RE?=
 =?utf-8?B?Q0IveFkyMzZ1SjBLWlZjUHhrazdSUVZzb05vMWhLdDYwdCtiMVZ5NEprWUE0?=
 =?utf-8?B?b2l0NituYjdGU3BNeGswQlZQT25kMnY5TGNHdytKYW1vejV1NjNHRUNicUJt?=
 =?utf-8?B?VDgyNmQ5c2drVEVBNFgxV3U5TXAwWDVKd1p3MXp2UGZieFhBbm5YMmp1SUpY?=
 =?utf-8?B?OU41RThuVVpZYVg4cE15WUdoZktBQk9IVUFacmZoakM0Y294enZONHV2Z014?=
 =?utf-8?B?TDdWek5Jb1pMbE1LckJCbnljREc2ak9HN2RiVzNkTnJSR1k0S24wcW9ZcnlV?=
 =?utf-8?B?OERzTjkxRlkwSU5xZXM1cU95bTFCdHNhZEZjaTRrbGMvOVZla3JFYThKaVk4?=
 =?utf-8?B?NDdzR1dDQWMrNksxdnk3MFIvQS9yQ0VsZDBFeXZOdTJ6WUZFaW50K2JkSzlW?=
 =?utf-8?B?MkhlcG80TTZBRS9vejZGVDFycENVRGpRa3dqdFBnMVFPeG5OWnhxd1BhVjYr?=
 =?utf-8?B?Yk0yWS9saEZzd3NPc21yVjVxd05xbUcvYzRVTlVmSEVkSk9WUmNLN0x5bzF3?=
 =?utf-8?B?R01OQk4rcTBYTjhReHNlTkJWN0FIS1RKY3MwT05ZKzQxMi9jZi8rL0Y1bDBI?=
 =?utf-8?B?T0hVRWZyRzIzdjF1NTU4bHR6SWk1ckJzRndoOFZkVUcxVFhlQkt0QWs0NjBY?=
 =?utf-8?B?N25uUUdhd2oyZ1FpSmVWOEROdWlVMlByWkxkMUlocitGS1hMKyt6dk5FbEpT?=
 =?utf-8?B?ZnFld25pUkFDSEhETHdTSzg5WVM4MGs5OUFZMm5mV1NmK2d2ZkRpakZIbG0w?=
 =?utf-8?B?NDRaOEY1ZzN5U2pudEdPVFZxQ2VjVFJ3TlBaSXpiVWNCMkV4STFqNmkzTUFo?=
 =?utf-8?B?ZHZ6WmhkQUdHcC8wMjhQeUtiZThsamlQSHJRQWQ4S0JWZHJBWXpwRVBwS3ZB?=
 =?utf-8?B?bWJ3QnRtL2ZhTWRuZ2NncUlzNGcwVVhMcGxMQXlLYkE1MjNnQ0tOVkhEbndO?=
 =?utf-8?B?andjWjkrUEpkSGs5U2ljU2V4VjZWM3huZGdDUHFUcUJMWWxadktzd3lXdVFR?=
 =?utf-8?B?V01qSks1aVRMYmFsKzRuMmJVNitNc3JiaDNVZHBZMXJYVnA4U2pKL05MOWhx?=
 =?utf-8?B?c0tUdXhraUNQa3N1UFI1QURqa2tmcDdHTjl6Vi91dWswRitka0NsNGt1MzVU?=
 =?utf-8?B?TFpxQlRxYWhkMEpoN213dUlqaVVBVzFVR1g2Uk5pWWNqMjZhZGRaQTZ3OGlF?=
 =?utf-8?B?WTBoY0ZLQStnVlJiV3k4djBtaWgvWlJjNGRFZldQYUlpZlJwWGZHcEtKcWN3?=
 =?utf-8?B?dEp4bzBlZU5hU3JiekV5QWRJdDRUS1VaTUN0QUpPblhGc1FaTFEvclRGL0U3?=
 =?utf-8?B?QitiZ0I5OXRDSUl6ckROSE1ySVZrRWlHU0hHR2pUZjczbHJtVGJ1RFpPMVJE?=
 =?utf-8?B?cHFRN2FhdUFBZnd3ZXBQWTgyeXBJcUg2MkZHQTA3UEZadFY2NzFzdTJWVUtj?=
 =?utf-8?B?elduZzZibVdYeTl4RCtRS3dFTy9xaXJCaWI0ZnNscDZ1cDdGTWFra2pFYzJ2?=
 =?utf-8?B?WmMwbEpySFBGaFBTNUNwRm40ZGtXb0NGdlJDcXZ6eXF4WllYWTdSMUhGOFlJ?=
 =?utf-8?B?bGtObVgyRW1hTlVuODFEVVBZRFdIbXhqZytENlFvYnlnbGREZjJ4ZEtoL01z?=
 =?utf-8?B?aHFhZFVuRkNKeHF3MEg4MG81czJRdDJTQmxyMyt1VFdGYjBmVzB5bytQZHpI?=
 =?utf-8?Q?Lu77HEMD7Zs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1QyZmg3UUdwVm5OSlNIb1NLNUxvYjlFZTM1bUVIbG5HbUNYc09TYWZNbHh1?=
 =?utf-8?B?V0ZJK0wzRVhoZ0pKVlFJV0txbmhHaHM1UFVxK1UxWXpoczhGdDRyWEZXZEtW?=
 =?utf-8?B?WnlwOGZCS0NnLzlQRjlMcWxtb3M1ZGFQOElJUjdtb2Z4NzVwTm8rUWZQUGdw?=
 =?utf-8?B?dk8rZ2QwT2RDOU9xWmYyTzR5S2VKNExJdmtndVFaekJDNUdpb09NbEk2UGFK?=
 =?utf-8?B?dGk2OG5UcFpiOURnTzlRV2pxaXlIc0lSVDFINzI1TFdiNC94SFAzcG5Fekxw?=
 =?utf-8?B?TlZhSmlZQkYyQW9HVnFua2Jxay9BeHpkbTROcjhDSDNyVC9JS0IvVlRnY2Fl?=
 =?utf-8?B?Q1Y2bUtyRmt0TlcvcnNzTnpWYnJXTmZ4MVliNk9UQUlIaE5rL2R1aDU2SHdn?=
 =?utf-8?B?VnU5ZHllRDlvL0hLL3VwYVFoTEE1S0kzRlBUS05HaStic3MxZWQ5d2VlazFT?=
 =?utf-8?B?TlA4Q3EyUTBRa2lnK1FwdUIxMWlBeTluQnZwVGdXUkVpWHlGb2VVRjVtelRy?=
 =?utf-8?B?L2MwSGFlYkI4Z2cvSHZXZlBtVEFZUnZ3aHlybnBNTStVK1padk1TVHVvRVlv?=
 =?utf-8?B?VVozRkZvc0c0VFhaRDV5Q3V3NHFjM3pKLzF2WmppdndIZHplem5PTWU4RG5Y?=
 =?utf-8?B?UVUrMjZ3alN6REgyVlFvYmppbUVuRU42TzZwSVhNQlhzQVNZQi8vS2N1c29D?=
 =?utf-8?B?NW5JN1l1c1dOZTh3eHF1YjJCRFFXWE43QTBZcVlJakc4Z0ZQZHE2cXhBQXhr?=
 =?utf-8?B?ekxIRGlsdjV4QUp2eDlNZDlDTjlzL05hdE9mdDJGbExGR2pKQ3IzUGNDQ25k?=
 =?utf-8?B?aFhFbFRMaUVOZXJETWR0djczR01hTFRpbUdUVktVVUQ5a1YwRS9HeFZ3RFlw?=
 =?utf-8?B?dHlPZjJ4cy9vNVlpOEZWWUxKTVBtRGVtZVkrc09BTWJwMFlHT1ZMM1R3YVpi?=
 =?utf-8?B?UngwYXVTZmdlbFNGeUh6bFYwL21CRlhqa0liV2NuT0t3QTEzTm5NeTg2Z0pY?=
 =?utf-8?B?UjNuWXI0Qk4vT1VpclVQWEhuNjBtWXF5ZDZhbEpQREpPRWwrWUJWNlpsOE9o?=
 =?utf-8?B?bVFhRjh5VFFFTVYwMllOaG83Nm9sUXo5N3p6dUVMdEU0NVpaUmk3dGhXUXJi?=
 =?utf-8?B?Vi9ueVkrcVM5M3VYOWRHdlVtdlpKUVVoR0ZJWC9GbStBVmJHM1VGYkZhc1JK?=
 =?utf-8?B?eWpvbEM1a3BYeGhHRHJGN3p3U3RQZzRPWUloR3duTTVMdithVzU2VkMxODg0?=
 =?utf-8?B?SkFJV0RsZjJUanU2VThveFBRYjdBT0ZDc215YStRMWVkMU9ac01NNXE4NHBT?=
 =?utf-8?B?eUZRanJ5S0pUQStOcEFzWjBCYkZrdmMzaE9CNlI5V200ZHRFMnNTU0RDbjdo?=
 =?utf-8?B?dmJSOEJlU1JiVXFQM0F0YTNnbXpjekZqZWpPZllUZ3dRVm1KdDg3V3VVKzY1?=
 =?utf-8?B?djNtUkdzMVhDbmp2bTZ6Z1NrVUVNMWNodDd4aVlrQVZNN0pnOXgxbFBuTkJ0?=
 =?utf-8?B?Unlkak9ZanNXQzlBL1gxSEtiK1d6UTVPdmt4eEozbWtRNDVNTnhkRUpTK3ly?=
 =?utf-8?B?c3JMc0xCUGMwYVJ4bGE0aXE0ckp6Ykk5VFd0blRKMFJ3SGdlWjduQlczdm9y?=
 =?utf-8?B?cEthS2RQd1pDWnVKR1BocDQ4TCtSR0JidkM3NWY3MGhNUDl2UUJzVlJndDVX?=
 =?utf-8?B?OFl2UW1mY1dRTll5b3ZLUGtxVGxXOTB5eElQdGttajk4elBOVHRUZEx0Y3JM?=
 =?utf-8?B?Z1JLNG9MNHJRTzI3enNremJpUVVMN2UvUnlzRTh3RUFqdDhQUW0veXdNeTg4?=
 =?utf-8?B?NjZheDBVZEZBQWFQZGhEdEJVQmJoRDk5N1A1cFBLbkYzajVLdnJoR3pXa0Ri?=
 =?utf-8?B?LzB2ZG9vWkNvV0dWTVZrQ081U1Nwb0FRSFgwN0ZlSStHZTE1S3c5ZGZVeEZ4?=
 =?utf-8?B?WUNSZm94SzJzMW9jMVNjOWd2Ry80VGg2V3JYOEs5cFdvbkkrYzBDanRvVUxh?=
 =?utf-8?B?Y2RyeXR0RkFHcUxMdVR5UytSeGxUeUVOdi9ESUVXM2FTd2ZtY0YrY29vU2FF?=
 =?utf-8?B?YlVPVy8wL1Y2K3NadVA2eDJUdll3Y1BIZUwyMTRpeFN2NHd6aFhUdlRZSERn?=
 =?utf-8?Q?wvH+KZYdgwQreDjnfa4a1YtqD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bd5e24-139a-4ff4-6d95-08dd78375c8b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 13:55:33.1173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlHm3jQQkj2BrQqzZgVifERd/87jDZ8sLBgXyjOoFCUpAdxc2SdxwTGOOVkDuXDsmeFDNJPPysUg6uJ7rVyNJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102
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


On 4/10/2025 7:01 PM, Alex Deucher wrote:
> On Thu, Apr 10, 2025 at 7:48 AM Arvind Yadav <Arvind.Yadav@amd.com> wrote:
>> This patch is load usermode queue based on FW support for gfx12.
>> CP Ucode FW Vesion: [PFP = 2840, ME = 2780, MEC = 2600, MES = 123]
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 3d87e445270e..c31c96fc13f0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -69,6 +69,10 @@
>>   #define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be05501
>>   #define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00300000
>>
>> +#define GFX12_ME_FW_MIN_VERSION                                                        0x00000adc
>> +#define GFX12_PFP_FW_MIN_VERSION                                               0x00000b18
>> +#define GFX12_MEC_FW_MIN_VERSION                                               0x00000bea
>> +#define GFX12_MES_FW_MIN_VERSION                                               0x0000007b
>>
>>   MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
>> @@ -1383,6 +1387,15 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
>>          }
>>   }
>>
>> +static bool gfx_v12_0_is_userq_supported(struct amdgpu_device *adev)
>> +{
>> +       return (adev->gfx.me_fw_version >= GFX12_ME_FW_MIN_VERSION &&
>> +               adev->gfx.pfp_fw_version >= GFX12_PFP_FW_MIN_VERSION &&
>> +               adev->gfx.mec_fw_version >= GFX12_MEC_FW_MIN_VERSION &&
>> +               adev->mes.fw_version[0] >= GFX12_MES_FW_MIN_VERSION);
>> +}
>> +
>> +
>>   static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>          int i, j, k, r, ring_id = 0;
>> @@ -1418,7 +1431,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>          case IP_VERSION(12, 0, 1):
>>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>                  /* add firmware version checks here */
>> -               if (0) {
>> +               if (gfx_v12_0_is_userq_supported(adev)) {
> I would just check the firmware versions directly here rather than
> adding a helper function.  The fw versions will be different for other
> GFX11 chips.  Also no need to define macros for the versions for the
> same reasons.  there will likely be different versions for each gfx11
> IP version.
Noted.
>
> Alex
>
>>                          adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>>                          adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>>                  }
>> --
>> 2.34.1
>>
