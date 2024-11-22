Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A15ED78767
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 10:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C506410EB3F;
	Fri, 22 Nov 2024 10:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jd0AfmSL";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B732210EB3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 10:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upQfKldtobr5uNSj5rsi/ZVoj2NETkBXbFxQmva63ugVxbAZKtOkLoNjShgPFb6gnPZfdAaRJY9qOMyrzTwFf1VFoIu7SlGs+eZRjfqUZ1bigaLlE+3JgtkISY4XfS0VrdBHk1fc5RhV0H20E+tV77VYLH38cLeZ1FA5qxlXJUE73NbLW+uAO47FmurvMjbUj8iu0dAV9HuYhz8kDtpGXOn6AnmCJ+Nfyq/8IuKyu7BIoBNuYHNmGbQs0z32Wb8cjvj/frxUlQz+EE5CTyuwWw5lDVmgnd1dh01Yad/X3Le76/RGQYbSBj7fwC3GefyVkGQlwnNk2Q8ud9X9MWL0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f582kSyFZu48y/1MReZV+Dh4SBGlE+V/yoWzoZWUpBY=;
 b=QmwvizS807CyW+NhjR32bowrznZge+zcKgiklehfzw1sLWls0L1zDEMGIcM1qF3kUimPX0I0jWC9J7mpmEqLbK9RGLR2S84M0IpLy+hC9bk/f3d/RQpxU5XszY0CcaTc1yxU+h3y8tzGfXOZCEdPaMer7LdCmAK5dIp0VK1FbvnKepl9ps2DnyicCECQWqB2YkWeexZ6BF6bpWSbod0mgXcF/Au8cqzbpMUGPWbcZW12O2dTViDdp+35jP2cxOx54ooIrjkFi2XTWQqt88rs9DQi3K74SWR/fNX65hrFVp/sIZSTbfkwcJS+etMNBke3rA7X/lTYfgedLd753WUS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f582kSyFZu48y/1MReZV+Dh4SBGlE+V/yoWzoZWUpBY=;
 b=Jd0AfmSLBdhnw59D1AUaHjZt7CqadP6qssVgyroIvAbUv92pgkudAOLy7cskVbmfLu4cEirrGXI0zwAtTy+r/1AQQvvnLELmRJK9/mRnTszAE5LzFGHEX1zqGNfNKoLsPFfWsUxLu+NXbkm3aKNBiWPW417ICUCooxGZUSvh4lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 10:12:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 10:12:30 +0000
Message-ID: <0d88eb55-c7e8-4163-982f-1dd02d777147@amd.com>
Date: Fri, 22 Nov 2024 11:12:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Update the variable name to dma_buf
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241122080336.2740473-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241122080336.2740473-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 802c915c-8135-40eb-2360-08dd0ade2c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHp4ellFeVlXd3h1TkNHU2NWcUxUcXFsTFhqSzBVR0JOTk5SbmtWa2F6MzFK?=
 =?utf-8?B?b2Z3TlkweENSL24yTStyZ2ZGNGxXdmQwT0xodXF4RkJlQm5TelJxTVZMV3V2?=
 =?utf-8?B?Z3VQYk8yMVhodStzbmh2ZGtQSTZnaXFqVUZsL1VEMlNXK3d1cjZpeERDOVJP?=
 =?utf-8?B?UjBPTkVIa29tZ1JFc0tmQ2ZjTjV3QnVQeWZzdi90dGRsSExIVjN4cGJSSGdo?=
 =?utf-8?B?bFZ3WTFzck5xT2ZoeUJQUUV2OHZHdWlvem1MMS9ZRlNzZzVUYlJLOGdqUGFP?=
 =?utf-8?B?Tkhoa0dpenE0a1hINGtGZVova1pNa2RYb0s0Wlk5bW9nY1BONGphUy9STjlQ?=
 =?utf-8?B?VzE4bUF0Q1duaUtTZGNMYUVwNEk4L09DU0xjdXlLd2puSVB6bG1DRXJoMkg4?=
 =?utf-8?B?aHBteGhiVG5sUU9rQzNIMkdQZzhZd1hwSllwTHNuM3hDU1VsN0Z5eU9GYzZP?=
 =?utf-8?B?SHhuelFVYUZtOERLQ29SWUZKWWVPQlExdXVnckE2cGxXU2oxR3ZKY1AzOWU4?=
 =?utf-8?B?ekJRS0NVY0JBdTdSbE02NXV6S2lvTGF2SG5TYzBsU3A1c3F3c3Q3bE4vdTlj?=
 =?utf-8?B?OGtob09RaEtCZnhkamt5OFNxZ3RNc3Nod0hwc3FPMG9MNTNtK0dRSkcxUDIz?=
 =?utf-8?B?MnhnQURUTVBMV3BhbkpwN0ZtUEkzMGhTMDlLRmZEMkUwbTJmVjhBdnBtQVk2?=
 =?utf-8?B?Z24zNWdiUnJic1FFdmprczEwOUNSTXI3dWZQQzJLMnpUWXRlNDZhRnc5c0Zq?=
 =?utf-8?B?a1BpS3MxaENiOG1uQVM5ZUtveUV3a05kVlkwK2ZGeTJ0alVaVTk1TXpnMWQw?=
 =?utf-8?B?UE1nSExjU2YwR0FGcmZFSVZmdlJiVHZPb0JKc2o3UU9oWFJwRlA2bWhybEhP?=
 =?utf-8?B?WjJnV0hHRVBHcHJwMWF2V21GbE9Jd1RraXg3L2ZXQ3BKV1RQSUdCR1RlRlRt?=
 =?utf-8?B?SE9Zb296WXRLV2ZPT0NiMzFRd3NVTEg4cm9DK1NOWXY5ajZMTFFYNHdhaGFH?=
 =?utf-8?B?WXFINXQ4UEVXSzZOQytTWVQzZzRIQnZvMDdEckhtRGFkejlTeUZmb2tmY29X?=
 =?utf-8?B?WEJYVWpFWlE5TXhLOFMwampGYkpreHdHNkdEenRXSm5TaXNOeE9GY3cvR3BM?=
 =?utf-8?B?eWtSRGxpUjczSnJ2aFZIK3pLSjR3aXZ2eE5ZQjhyQmZhSWFINnUwQUpNdk9w?=
 =?utf-8?B?bXMxWWV4b0Q3QWVGMEdTZVlFR3BDbHVwc2RTSjNiT2NjYm9qU0dZZWpYTEc2?=
 =?utf-8?B?TkJ2MkpPdXh2aHZpNnFyNDRrb0RKK0M0T01IVE9YcWFCclRYZ2VHWlhQc0R3?=
 =?utf-8?B?U01SYmYrbFNzZTRJdVJaRnFGclBOd2kxVStwS2dEQ3o0SjZVU2ZHa21waXpV?=
 =?utf-8?B?clN4WXhHZlhCRXpUOWNsTk14WGhyajluYnIrRktKRjNCMUM0a2Q1VElDUmxa?=
 =?utf-8?B?OURTRitTSjF2R1BTK3BFdDRTaUtUbVJ2amFnRDFaY3VYUUtKYTRYWFp1UHlL?=
 =?utf-8?B?UGJMZGFmVG9IOG9jTXhENTdSYjZtZ29mTGttMVZpQmw5aFhFTG5PYkdMcGdJ?=
 =?utf-8?B?NGZreUV0eVhWd0VDLy9lWjRGb1l0RFF2NzAxZXpLNnhTNlB4YkpEU1RvdUhW?=
 =?utf-8?B?R3UxZDZaMGd2cWI5eTNRTDJPU1FKR0xSR0FnaHBMUHR2QmMzRXljR0VXRmow?=
 =?utf-8?B?NE5SdFg2UUthbGF4WjFtS3VjSElGNGNUc0JFcmdYZU1udlRDdXcxQTZMY0cw?=
 =?utf-8?B?QjU1ay9JZUhNemxOc3JrRFRkSEY0S24yeTZBa0pXdjlFWC9zYm1aSWhvV1ZE?=
 =?utf-8?B?RU9MdjQxTlBNMGthRUFuQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S21XMHNlc3JsanU4M290Y20zbVBVdkV4ZzVkV2VIU3A2M0lFR1Q3a0Vxbzhj?=
 =?utf-8?B?RnRlR2ZiMzZERUYyendIRyt3TU1QVTdNVXZkVlBlQ3loOHJ3bkdSNjFzTFgx?=
 =?utf-8?B?YzZJTFZLbmh6cHdMQm5WNlcySWRhTHI2cG0vQzkySXhPT21Salh4TDRTWU0y?=
 =?utf-8?B?UFRZcGdCY2VwREJnM1JETGZMRDllOEw2VHlVb0pHNkxxUWVDVW4xMUJaR1Fq?=
 =?utf-8?B?eDVVMnI1OGYza3VDS1lBQS84aUxwaGpVYXE1QXp4ZmVVSXJReDNsbTVEeFJK?=
 =?utf-8?B?T0ZZSFJhV3VpYk9SMzZvK3F4M1FqNmpPQy9KdENCTGcxL2dQMUVVVGdESmx2?=
 =?utf-8?B?cXBkZVlQUGs3K3o2Ryt4ZVlRdzQ1ZlN1eFZIK1VmNWFPenl2MWxPSDlCSlQ0?=
 =?utf-8?B?NWNJV3ZRZDdYQWZmR2hTbFRFeVdEYUZlMHdhYVdjeXp3aVdvUURlS0NqMWNv?=
 =?utf-8?B?QlRhN29vY3RjSm96ZFJldnNRRkVlbHZpVW9OeGx5aUlaNTlZN0I4ZWRFT0FI?=
 =?utf-8?B?bWpvMmx5Q1hQR3VIMWtBNW50S3prUStENU5nakNpdVNSYVRFd3pLYnBYaVdo?=
 =?utf-8?B?T1o2VXFPWmVMb29BRnJkSEJRSUpnMDdjbDd3ZXg0SnVoQ2ZFTldkT1VVQmxT?=
 =?utf-8?B?VlR6T2ZWZDd0eEFieGIyeVJZaGFReDNZNEg5YWMzZmlRV2F5YVh5alFiaWJZ?=
 =?utf-8?B?VVFzR05hZUY5UE45WHlHVWFBM0xxVThYL0VodDFldlpWeXNqd1JzV0dqUE1x?=
 =?utf-8?B?QmFXeHY2S2oxL0tVcEFtaUhJdlRoM3Z5Vy9sMU5wTUEyNDlsVzRDbjJGejdN?=
 =?utf-8?B?Z0FUalFLc0syTmJEYmxCZWN1MmJsbXBXNFJyMElaaWEzTWtSNFlEWlFBRFJp?=
 =?utf-8?B?cFUrVzJITlFyQ1pEbHdxc3RUeWEwdCtWSFBtaW54c0x5bnJGMkxYZWFPdXRC?=
 =?utf-8?B?NXJYWk1yNVBvekFXKzBkbnZQRHAzV0tITExpMzVsbmNTSU5WN1JtR1c4ckt2?=
 =?utf-8?B?Ui9HTG5naCsrSDVTeDR6bjB3R0hVV1pSU1FrUktOL3o0dXd0VFlyK2RDZFFP?=
 =?utf-8?B?QjRFQmVzMXVEWWovb3BMemFIVU1aLzUyelplY0FveXJKTkNnQzk1cnlSK01E?=
 =?utf-8?B?Qk5DY2ZNSEdXNVdLeCtia3dmaGlnbTJUWXVlaUVPTXQwREJJUGJnYjF6U0lS?=
 =?utf-8?B?emZGbnhYRnRBT3BNb3dJZS9LM2NhTnlMc1V5T0dXalpjay9iZ0t4dVlmQUwy?=
 =?utf-8?B?RDZCY3NVbllTbWlUQUNsZlJydzFlN0d0bzR0VnBVKzY2R1E5ekdUbTh3L1Y2?=
 =?utf-8?B?OHF2QkU2Y2NORjExeHNSZjBrMDZ4L29leVQ1aFZaSDhLeU0zZEdOZU1pRW55?=
 =?utf-8?B?bWg1ajBac2U3WU85bG5DUjFLOXRCb1FyajR2S05lNmRhSCtqS0FDQThHd01v?=
 =?utf-8?B?N3NKVm1iNDhwNGJ1WjFERzRTSjdFNi9yQWErdDZ5bmJ2TkVEcDA2UFErV3Jk?=
 =?utf-8?B?K1FacjExZ21Qd3pMU3d5aG9CNXgzQ1JsQnpsemdvcFpreGlwT002OXlGMk0x?=
 =?utf-8?B?Zy9YYkh5WFdlTXJZNk0vdVc3QmoybnpKazNVYVJyK2tSY1pZaUJENi91UzBH?=
 =?utf-8?B?Ni9HWmFlYjZyV2NsT0pLNjd4S09sSEhMd3ovTXlndjFFSW9SbC80VzBTL0hZ?=
 =?utf-8?B?OFFtUmtmSndQUjYwcUZ4WDE0MnZjNDN2UU10MU93UlBZS2hjZVorbGQ1U3dH?=
 =?utf-8?B?RnFIaDJkMmdxaXVvRDFhSTZlOUJhWUFnMWVYNEpMSU41WWR0ZExuRXZZaXFq?=
 =?utf-8?B?ZVloZG0xVjBpTklFWnlvOWtkaTFjVTJYSnBhdS81SGlPTHdwYW52Wm96L2V5?=
 =?utf-8?B?STlRVmVuT1dlUHJMQWM1NlBLZi9OMnZlOFY0M0U3V0x1YXRyb1NSbWxJd0xX?=
 =?utf-8?B?djhEL3NXRWVPVkg2R3hDL2t6eElEcnFMbFBtLytmUGN1Mzg4R2NzbmdodXFG?=
 =?utf-8?B?Wkw4MjlSZU9TaGEwK0tYRFBIUVRTSEpwR2VTVTFGMWRwYnVKRGR5TSt3dWJX?=
 =?utf-8?B?cEtoRmV5RXVsZVhKN0ZOcTZTcU55Zi91Z3J2RjFDT3l2c1AvTmo3UGJsTHBk?=
 =?utf-8?Q?6pAvTK0sQ5A20xMWpsm4W0/qf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802c915c-8135-40eb-2360-08dd0ade2c8a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:12:30.5228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WywPFzj0KD9pr6KKcYGOuIM5qB793r9ghSPbfdZ9YNnXr1iovMDNeKsWZ+NkVotT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

Am 22.11.24 um 09:03 schrieb Sunil Khatri:
> Instead of fixing the warning for missing variable
> its better to update the variable name to match
> with the style followed in the code.
>
> This will fix the below mentioned warning:
> warning: Function parameter or struct member 'dbuf' not described in 'amdgpu_bo_create_isp_user'
> warning: Excess function parameter 'dma_buf' description in 'amdgpu_bo_create_isp_user'
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e6d218839f9..4f057996ef35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -373,14 +373,14 @@ EXPORT_SYMBOL(amdgpu_bo_create_kernel);
>    * 0 on success, negative error code otherwise.
>    */
>   int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
> -			   struct dma_buf *dbuf, u32 domain, struct amdgpu_bo **bo,
> +			   struct dma_buf *dma_buf, u32 domain, struct amdgpu_bo **bo,
>   			   u64 *gpu_addr)
>   
>   {
>   	struct drm_gem_object *gem_obj;
>   	int r;
>   
> -	gem_obj = amdgpu_gem_prime_import(&adev->ddev, dbuf);
> +	gem_obj = amdgpu_gem_prime_import(&adev->ddev, dma_buf);
>   	*bo = gem_to_amdgpu_bo(gem_obj);
>   	if (!(*bo)) {
>   		dev_err(adev->dev, "failed to get valid isp user bo\n");

