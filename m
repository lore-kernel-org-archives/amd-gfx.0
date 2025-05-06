Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C48FC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 08:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F0E10E5F8;
	Tue,  6 May 2025 08:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iet/h70X";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C7D10E62E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 08:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiXybx1rfc1yBeA4PU8UWfbv4DNJW5acoPx65Y+hmAy+e3q3mdwFmNHIAfjSyib8rTZyx/LyCoCrKXoqm+HAbsbdCor4jpRi8t+RJbEIfAQRMKFx/drUt+c8cJ1uGwC7s8gQBAwfLkj2eubndcY3+Hq476dbc1p2wK/2oZbiF7fgOG4knumwB8eOSeEb4PTXb+Wb2ci4wp9cmb55f4uAZAri8iXYht0EKBbPuXY64U6iIuO3H83JPzI41j949Xupv4mJLsJecUBX7KWmIdyOkwMXMysX/nqFHR4qVgmn5VSaFv8cxn88Piq7kq4bj3ad1JylFavDX4rtWdkDYWkwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAA88bQjsyfOwhttMGF/4YgLCRUFniEKA9DmBGZMVQo=;
 b=oSYZ/Vl+iGRnZE9VZSV7iR8RcPG8GEBLgO6QMMmwl4/x2+laJORLfFG0xbFvyVHSrP1n0ThRv93pFQdDgyVQGOFfGWAZoidzeV/G4NI1ZQZyRQXxADKvlACqK77mzPfY6TSPKDietfm3MlYBgAa2tkkQybkO6H8an9lh4daOF1tlj3Eb+6Li9ed+0PI6+WWz/F1n0RX+BzZ54B1V1b6pluuH8tPWRkXsUfyWxFlOam+EJDLkdGMpawB9HJNULtN9oaBk555lJCraqb/V1WzBbSzsIhHqSfpDiTd7hes6c+JR15SBkKm9nrUM2Ny+CGH++5edd2yK6zEd8p0/2hIe+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAA88bQjsyfOwhttMGF/4YgLCRUFniEKA9DmBGZMVQo=;
 b=iet/h70XZjHeeOdYPErmAgEtT58Bg6TZQHGiXHrxnYUrrcBqZb8x/XAgbTC1F5Mod+poGhgx2MITUKA6FjuhexIl1iSlyDTcJdkQwHWUwCvodhX8NvMx8kHq8F6lLBNbUZg12ZlefhwZQPZZy5NyIuYiorUpzURGOyFDDDh2i/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Tue, 6 May 2025 08:53:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 08:53:29 +0000
Message-ID: <1f5754e5-f51a-46f3-9b4d-db417e7b5dd6@amd.com>
Date: Tue, 6 May 2025 10:53:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU and PSP
To: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>, "Zhang, Owen(SRDC)"
 <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>
References: <20250430101638.649274-1-guoqing.zhang@amd.com>
 <20250430101638.649274-3-guoqing.zhang@amd.com>
 <487f0345-3ff8-43c7-b26d-03e815c2d1f8@amd.com>
 <DM4PR12MB59375EF7DA8EDD89E1AF31A3E5892@DM4PR12MB5937.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB59375EF7DA8EDD89E1AF31A3E5892@DM4PR12MB5937.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:208:23c::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4ede53-aa9c-4c28-3db7-08dd8c7b78b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkNWaWtydWtGVEwvOThGZG5POVFFQkRLL2lVMnE1aTRka1NIR2ErSitNbVpJ?=
 =?utf-8?B?d2E5RXJFa2k0TWJMbmZjcklRY1VjV3ZxeG5GODBRaVdUeVN4STA5N0hqTnR4?=
 =?utf-8?B?WEJYQVpZVU9vV0hBcUl1R2lFY3pDSTlicnVjSmMvT1JDOWg3WG4zUFRWTUpi?=
 =?utf-8?B?TGJIc2ZLV3FPZVUza2s5TnV0c1B6TmloQnlSdUdjTGYzQ05naGtENmdWTFVO?=
 =?utf-8?B?V2RGZTlvUFFhVEQwS29kZHBxYzI3ZjlNTnJBRTkwYTlmbGFyaDBaYU5ZOXdO?=
 =?utf-8?B?K2NIQWcvUUNVbjZETjNOdmFURVhWYjBMbWUrRnNrS1VPYkIrcit0WHJqb0ZR?=
 =?utf-8?B?VkRhVlhrUGdqUXFlOHBlWVRZZTBIRG5oR2Z1WFNiUXNwbG5JYjg5aTU1ZmVF?=
 =?utf-8?B?T0NqUXBiQWxtS0VFc3IxNnRvWjI4RFQ1aVB6WnlHZEJuMnJNekRaaytOVEp6?=
 =?utf-8?B?WUg4Y2FFT3JMQ0tvSjZTRnhkUFRmZENud1pTN2x2WURacmYzS29VTWtROG9Z?=
 =?utf-8?B?dHovZzcvVElYSTFRNzdncWlCM3gwbmY3N1dJTkEyYkhaWDU1VVFTalJzZFFH?=
 =?utf-8?B?Z0tWWXo1VEgvN1ozbHU1RGdsVUpuaSsvbkQ4TktIZFNhcVRSUUMvYWJ5ZVdl?=
 =?utf-8?B?SXZjQndpSkhtUW9YR0svNTdlTW13MmtpRElOTHRVUFpvTU1pY2laNVN1QVk3?=
 =?utf-8?B?WWtUNUd1c3FqdkxTRUhIeFdlYkd2V3gxWHgyb2h0Wkt3Tm1NNEJ6d2RMNGJh?=
 =?utf-8?B?SkorS1k0am8vQ1ZiSXZhNXY2VFQxR0lKK054dVhvd3dyVjIyMXVZUkVYWWpu?=
 =?utf-8?B?N3NjSGtzTDZldTBhcUlsWmdyMmo4a3lNb0JyckVkcFFmZEQ1VTF5Y3JwUkFX?=
 =?utf-8?B?aUtja01jbkFUV1NmUG81NGpndlAwd21obEFMZmFWRElxMmJoUzN5eGR6eWFv?=
 =?utf-8?B?cjJKeGN5VTE3cjZlbDBCZEVSMUFaZFd0S0JPd2FuWi9SVDJDSmVBL2xBWjl0?=
 =?utf-8?B?Mk8wai80eDdmcmd0Qm5Ic2tPRU1IUlFNdmpsbFRFTlBwM3oxK2FyTGdkYmVG?=
 =?utf-8?B?YmVDbmlTd2NGTnlJaHJnNmI4MDJRL1d1UWlmTjBkRzhWbHR6dzdOYmNCVlgz?=
 =?utf-8?B?VGdsZWZiL0ppYlM2Y0xKb2xXYko5eThpYVNmeXVKUzhBNjlQMzhmUklYVTdU?=
 =?utf-8?B?QUtGTkxzQ1FmeDBrT0JZcDRZSDVJeUc3MmxlOEV5TlhoVGx1cHBFc05BMG51?=
 =?utf-8?B?Zy9TYm4rOFVEWDN1aGNjSmtabEJMQmkzSFJ3WER4Mi9TNWtLNkRoclgwSmU3?=
 =?utf-8?B?SzJpczFzdmhqa2dpTjZlZUZQU2EzVXd0YU9kdFgwanpjeWxlZWVkWXJCYklX?=
 =?utf-8?B?cWdLV2dLOGVWRStrRGlzTzVySDg4SG5oT1RJY2dpUExodEhsRnJlYTFxMnVY?=
 =?utf-8?B?V04wOGpPdWtucVFRR0N2SDRCS2poVHFzVFhFS2NNQ2J5QUR6bFUrekhJQzAv?=
 =?utf-8?B?RHQ1eWM1UGVsTHBHeHMzZVBPNkxMVkdzRnhCYUVBTE01cEw1cG1tSEZpOGRY?=
 =?utf-8?B?ZkhZUDkvSTBwT0JGWFBtQWE2U3FCa0RES1BZWG52djhPNS9xcVd4MzA3Mkpj?=
 =?utf-8?B?MldRM1F1R1lrNnY5TlJkK0V5NFR2Zk53bGlhK0FhQzFFUDhTRnBCWGFOZXdy?=
 =?utf-8?B?WDFqd3FxL1NkNnhyVk82TkxnZ3pZYTNsUGF3Tld2a3pWbGZKL2ppeFhiYXBz?=
 =?utf-8?B?emZIMUtubm1lcTdCRFNSNVpITlpQQno0Y2ZyaVBEVHRZUjRBOEdUSkpxVU16?=
 =?utf-8?B?WXA3N0JRQy9KTGo5c2oxMk1MTnEvWWJkYjdWb0ducUcvQ1VoemFqUDBLRUlh?=
 =?utf-8?B?eU5hNUNoNERDSU5WaC9BNDRRZFVqeWNpSmVCUXc5T1VRaVpvdld4L2xsVGgr?=
 =?utf-8?Q?kKNJ4svknOs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVljU05QTDVSVVVJOWgwTEJPNWMzWW81UVVqQnJzQURtTjRRdDZVcXZDcUdE?=
 =?utf-8?B?VFZCQ0JQcG8wQVlNa29PcWFiNlNHTmZRRVFkWmg1TENkU0dBRk1wVVA4b0x3?=
 =?utf-8?B?YnNCL00vbFhKTC9CN0xRVmV1WlRwWllSYUxlVUFmTFEvVTRyOE1vcFNPc1By?=
 =?utf-8?B?WkczdFFjazFtb2N1Q2FQWkw5RTJ1YnBKRnlobHNEQUdhd2F2MmUvYlRwS01L?=
 =?utf-8?B?U25kYTFoaFlXVHZ1dDhXQjJZWmNjNSt3c21NdXlKMWF6cjJBQU5RY0dOZFZi?=
 =?utf-8?B?V0pCZzNsV21tZ05nZDVldks4TmRMamZkUGdKSkNucVlNYkJEaVlER3ZiM01i?=
 =?utf-8?B?OU5PNTdqUi9vM3lGWGJQNXdKWFhrTEhWNTEwdXhRcFg0dEcvRktneDBlcVIw?=
 =?utf-8?B?ZDdhVmRpbUlkTHhzam85NWVPdEl6UWhYVFAxMnduTWlzRnA2Q1BrQzFmM2xM?=
 =?utf-8?B?QUEzYmVYVktLMTlGeGNiR3hrSml5ck0wZWd0VDJWUE1weVdTOWRMMjFFZUJN?=
 =?utf-8?B?OHgrREE5MnhKenVKWE5PSm1xRGc4UHN6OUhZZHUyVVdGb0NlcTFFazdiQ1NE?=
 =?utf-8?B?eTJEUVlGNVl5ekMreW5GYWNrUnk0bHdzeWgzT0pLN0d1ajFTNGVhU1Bib0oz?=
 =?utf-8?B?bjZENnY3dVQvUkNLdXAvWXZCaFdTSHA5eGY2YWFQb2w0UnQxN2hxaTFQTjdX?=
 =?utf-8?B?VlVDellFNXQ0eGp4WEdNbEZQeVp0dmJuc09hRndUL2J4VTVsUmJwUkduM1pC?=
 =?utf-8?B?a2RnaXBxYWl3VE1qU1JKelR2K2k3RDFVRk8wUkRWSzRTVjVRYTZtMXpUaE9T?=
 =?utf-8?B?bHhXeUoycGEyT2tLeVBSZlFLa0ZnemRZcjB0SFVWQ25WSS9KNTJLN2htMEoy?=
 =?utf-8?B?QUNIVVVHWFo1bll0N29pNEQ5WHJKdVVkQU8wVmUweVVnc2pBNDF6WnNEbXlD?=
 =?utf-8?B?bVlwRTRma3RJeVZpWGdHVUdGOFltT09qakErM0drTnVMdGdib2xiT0JsZlBV?=
 =?utf-8?B?cWVTM0lzWFZOaERObDF5K0gyR0NjSVdQVjZXREVEYmtIVkZMN01ON0hyMU5z?=
 =?utf-8?B?OURHWHhTcitFdVh0eFlyVzh1Tm9jM2NKY256ckgydURVRUVaS3pyR0VBQWJ6?=
 =?utf-8?B?SVl0cUpkOEVMaGlWeFVwcDBMRVVESmxPQUs2ZTcxbEhMMEdQUk9CTno1cEIw?=
 =?utf-8?B?VkdXQkNzalE2TWZQaVpoaWJYcm03UTAyM3JSYkk3eVhNN0lQS2hQRDBZRGQr?=
 =?utf-8?B?dzJwbUd2Z1NPbmxOMW9JZFV5UTFwZXhTaVE2MnFlS2xwYzgzZmJLY3NwN2hj?=
 =?utf-8?B?NnJqSkEwRmNGc0tJSlNmcjhPaE5XSDhjY2pTNHkvTlR2eWp4bXdmMU52SGpl?=
 =?utf-8?B?U1BURitPWWVwZDhtMmZ1L0NxUEwwcDMvSkdCMTZ5Y3pJWFpUU0pBdVNHOTlW?=
 =?utf-8?B?V1Rhb3pxSlVyOTNaSGxVRitOL054eUFGZmhaNkJxNjVvelE3VFBaN216UjB2?=
 =?utf-8?B?dDR5Y3VMT2d3M0JXVGlzWkdiS3J5STlxQ0J6bTluQ3hzYTRHQkZUYnNJaG84?=
 =?utf-8?B?UXhOajF0b0NpQ29ycytWTEdKMzlYUFA0T0tUdk9oQ0VUb0lXRVVuaytDWDhF?=
 =?utf-8?B?SHhPUkZuZUxoTXNYb0VJZ1dycStxZjhsNUd6N0trZFp1YnVRbUtOYkVnRVNJ?=
 =?utf-8?B?SEtjdC9lZFNMUnh6Q21KYThaMkU3RmFrbFcyV0ZDSUJQMzhQam04Z3VBM3Ay?=
 =?utf-8?B?SUZ6SGF6Q1hqdWQzUDA5QjBua2VhblhFaUtpVHdwOXQ2UW1CQThkWGRTNzRD?=
 =?utf-8?B?b0VYOG41WHE5VnhwQjZuZnZBZmZWMGV4dnZCeFphU0l4cEFZNDkrM1RWM1B0?=
 =?utf-8?B?OWtkVWFSd1Z0VG10L092a0VtVEdwRGFjUjJMZlVYeTU1OGVmcGk4dUhSNG5P?=
 =?utf-8?B?d2V0TzU0enc5WlpQNkJjbUhHK2FUSmFpVm4zYU5WN3BWT2VkWW1YV2V1OXk4?=
 =?utf-8?B?ZHplbmNucTAvbTg0MVhwZFVLME5tRG1EYVlDTEN4L0lsRVRvYk84ZkZqNFl6?=
 =?utf-8?B?dTd0eHpGRlZpbmtrV0hUdG5mNVNOdmhialR3SlJMdzUrMzZBTDJWSW5GVUdS?=
 =?utf-8?Q?uw63+HlLV/+hL0KvyIERnyCJp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4ede53-aa9c-4c28-3db7-08dd8c7b78b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:53:29.3163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+LAT0WUijxPAMzd6l/zcOUO4gwUYyFyFufkeQKCqPPYqwic9Qp2TMRayKSaqcyn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
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

On 5/6/25 10:49, Zhang, GuoQing (Sam) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
>> > @@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
> 
>> >        cmd->cmd.cmd_load_ta.app_phy_addr_hi    = upper_32_bits(ta_bin_mc);
> 
>> >        cmd->cmd.cmd_load_ta.app_len            = context->bin_desc.size_bytes;
> 
>> >  
> 
>> > +     if (context->mem_context.shared_bo)
> 
>> > +             context->mem_context.shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
> 
>> > +
> 
>> 
> 
>> Rather put this into the psp_prep_ta_load_cmd_buf() function and remove the shared_mc_addr member.
> 
>> 
> 
>> Please double check other similar cases as well.
> 
>  
> 
> Removing of these members are easy to change and test, since they are used in one c file. I can make one refactoring patch for each removal.
> 
> - ta_mem_context.shared_mc_addr
> 
> - amdgpu_firmware.fw_buf_mc
> 
> - psp_context.tmr_mc_addr
> 
> - psp_context.cmd_buf_mc_addr
> 
> - dummy_read_1_table->mc_address
> 
>  
> 
> Removing of these members will involve changes in multiple PSP and SMU version files. For versions that MI308 don't use, I don't have the environment to test the changes. Should I remove them as well? @Koenig, Christian <mailto:Christian.Koenig@amd.com>

Keep them as they are for now. Such cleanups can come later.

Regards,
Christian.


> 
> - psp->fw_pri_mc_addr
> 
> - psp->fence_buf_mc_addr
> 
> - psp->km_ring.ring_mem_mc_addr
> 
> - driver_table->mc_address
> 
> - pm_status_table->mc_address
> 
>  
> 
> Thanks
> 
> Sam
> 
>  
> 
> *From: *Koenig, Christian <Christian.Koenig@amd.com>
> *Date: *Wednesday, April 30, 2025 at 20:51
> *To: *Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com>, Deucher, Alexander <Alexander.Deucher@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
> *Subject: *Re: [PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU and PSP
> 
> On 4/30/25 12:16, Samuel Zhang wrote:
>> add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
>> the FB aperture address for SMU and PSP.
>>
>> 2 reasons for this change:
>> 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
>> aperture address, it is not compatible with SMU and PSP, it need to updated
>> to use FB aperture address.
>> 2. Since FB aperture address will change after switching to new GPU
>> index after hibernation, it need to be updated after resume.
>>
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 22 ++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 17 +++++++++++++++++
>>  7 files changed, 63 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index a2abddf3c110..ef6eaddc2ccb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -209,6 +209,7 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>>        uint64_t vis_limit = (uint64_t)amdgpu_vis_vram_limit << 20;
>>        uint64_t limit = (uint64_t)amdgpu_vram_limit << 20;
>> 
>> +     mc->vram_offset = base;
>>        mc->vram_start = base;
>>        mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
>>        if (limit < mc->real_vram_size)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index bd7fc123b8f9..291d96168a57 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -251,6 +251,7 @@ struct amdgpu_gmc {
>>         */
>>        u64                     vram_start;
>>        u64                     vram_end;
>> +     u64                     vram_offset;
> 
> 
> Please don't add any new fields here. We should already have all the necessary information in that structure.
> 
> 
>>        /* FB region , it's same as local vram region in single GPU, in XGMI
>>         * configuration, this region covers all GPUs in the same hive ,
>>         * each GPU in the hive has the same view of this FB region .
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 4e794d546b61..ca29270f66d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1513,6 +1513,24 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>>        return amdgpu_bo_gpu_offset_no_check(bo);
>>  }
>> 
>> +/**
>> + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
>> + * @bo:      amdgpu VRAM buffer object for which we query the offset
>> + *
>> + * Returns:
>> + * current FB aperture GPU offset of the object.
>> + */
>> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
>> +{
>> +     struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> +     uint64_t offset;
>> +
>> +     WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
>> +
>> +     offset = (bo->tbo.resource->start << PAGE_SHIFT) + adev->gmc.vram_offset;
> 
> Rather use fb_base + XGMI hive index here.
> 
>> +     return amdgpu_gmc_sign_extend(offset);
>> +}
>> +
>>  /**
>>   * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
>>   * @bo:      amdgpu object for which we query the offset
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index dcce362bfad3..c8a63e38f5d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>>                             bool intr);
>>  int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>>  u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
>>  u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>>  uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index e1e658a97b36..bdab40b42983 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
>>                                              &psp->tmr_bo, &psp->tmr_mc_addr,
>>                                              pptr);
>>        }
>> +     if (psp->tmr_bo)
>> +             psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
>> 
>>        return ret;
>>  }
>> @@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>>        cmd->cmd.cmd_load_ta.app_phy_addr_hi    = upper_32_bits(ta_bin_mc);
>>        cmd->cmd.cmd_load_ta.app_len            = context->bin_desc.size_bytes;
>> 
>> +     if (context->mem_context.shared_bo)
>> +             context->mem_context.shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
>> +
> 
> Rather put this into the psp_prep_ta_load_cmd_buf() function and remove the shared_mc_addr member.
> 
> Please double check other similar cases as well.
> 
> Apart from that this looks rather good to me,
> Christian.
> 
> 
>>        cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =
>>                lower_32_bits(context->mem_context.shared_mc_addr);
>>        cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =
>> @@ -2336,11 +2341,26 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
>>        return false;
>>  }
>> 
>> +static void psp_update_gpu_addresses(struct amdgpu_device *adev)
>> +{
>> +     struct psp_context *psp = &adev->psp;
>> +
>> +     if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
>> +             psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
>> +             psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
>> +             psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
>> +     }
>> +     if (adev->firmware.rbuf && psp->km_ring.ring_mem)
>> +             psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
>> +}
>> +
>>  static int psp_hw_start(struct psp_context *psp)
>>  {
>>        struct amdgpu_device *adev = psp->adev;
>>        int ret;
>> 
>> +     psp_update_gpu_addresses(adev);
>> +
>>        if (!amdgpu_sriov_vf(adev)) {
>>                if ((is_psp_fw_valid(psp->kdb)) &&
>>                    (psp->funcs->bootloader_load_kdb != NULL)) {
>> @@ -3976,6 +3996,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>>        memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
>> 
>>        mutex_lock(&adev->psp.mutex);
>> +     fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
>>        ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
>>        mutex_unlock(&adev->psp.mutex);
>> 
>> @@ -4085,6 +4106,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
>>        memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.vbflash_image_size);
>> 
>>        mutex_lock(&adev->psp.mutex);
>> +     fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
>>        ret = psp_update_spirom(&adev->psp, fw_pri_mc_addr);
>>        mutex_unlock(&adev->psp.mutex);
>> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> index 3d9e9fdc10b4..f3b56c219e7e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>>                adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
>>        }
>> 
>> +     if (adev->firmware.fw_buf)
>> +             adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
>> +
>>        for (i = 0; i < adev->firmware.max_ucodes; i++) {
>>                ucode = &adev->firmware.ucode[i];
>>                if (ucode->fw) {
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 315b0856bf02..dfdda98cf0c5 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>>        return 0;
>>  }
>> 
>> +static void smu_update_gpu_addresses(struct smu_context *smu)
>> +{
>> +     struct smu_table_context *smu_table = &smu->smu_table;
>> +     struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
>> +     struct smu_table *driver_table = &(smu_table->driver_table);
>> +     struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
>> +
>> +     if (pm_status_table->bo)
>> +             pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
>> +     if (driver_table->bo)
>> +             driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
>> +     if (dummy_read_1_table->bo)
>> +             dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
>> +}
>> +
>>  /**
>>   * smu_alloc_memory_pool - allocate memory pool in the system memory
>>   *
>> @@ -1789,6 +1804,8 @@ static int smu_start_smc_engine(struct smu_context *smu)
>>        struct amdgpu_device *adev = smu->adev;
>>        int ret = 0;
>> 
>> +     smu_update_gpu_addresses(smu);
>> +
>>        smu->smc_fw_state = SMU_FW_INIT;
>> 
>>        if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> 

