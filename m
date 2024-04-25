Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E642CC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 06:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A25E11A1CC;
	Thu, 25 Apr 2024 06:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YBB02GFT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB4D11A1CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGCheQ8GANVi+OtMksRP4as33qYcwA550ve1ZouQE9fpUFvKVaQ3jjdlT3TzlKdseBJMbqCUSgfx5tQ81MEOqcX61iQ3CHvnZRqjjDIVSliXdI3Htc8wA2VYzxZY69lx+J9jjNkMl8d5o5I060Y3Vt6iunQwl1DuTR4cnLuZwIBCOT5kkNHPI+I3WYtkYPV6aAzpQzSYcHN+ttuD7ZFSiS/kRaweb8KUU6zUeDX3ReJzYrE9bMOMxKmcxufUNkgk/Gj6glGYC5flz5N1IGnXn0u1GaojD/GWIb7JSD42x155BomlrrTsxNcHqCp5KdGHI22ilUaWAJjk1KnAc90Bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UXVYfPSL3G3t8MnTaAq4473R/OfjDSlx/hC9Oxk85U=;
 b=YFqqXIQpl1UK/qVrnMQ1kp/DILeCbgQ/io9aFecuS2UBZVI0xt2SyjtqO9tsX/4loUBBQ7sBJdzrm4vIU9dAVdvrYPfyk1dfPamG8ZB4c9kuvAklHgWfELk9c7G6Y/QrMMSzAZeDVPTCYjXgwvhksDCi/rdiwtHfmPBNLwMvLXotRUGgTJ2n0wIfPnl2Yy6eC1rb+NyzhEMd4r0dfMAACXgwhd7ek4AqgHtaM1qQrGPEuanULh8EWDEwk+kr3I7Wvw603lC7rGQVOpuk8EmaBJJlHdp0T5w5BJR8JS8uZW80s4ev8g8g28wt6Sf/Y7lZ5gLESQw+5Jp+ITy+F9iBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UXVYfPSL3G3t8MnTaAq4473R/OfjDSlx/hC9Oxk85U=;
 b=YBB02GFTETAAxxjmkzXvBLLaReUilgqAvXU8kJ8hJeE3eY+p2d/3IZCC2Rm4eXGezDi5XAKSC6N2/y1TuPuyNP2uJBhzLj8/BqhVHMyOIosybDd6w3fAVv2KkZpx+AarkDw6xgL9bK1uAFWLBGzrkisKRWHLFjwyOP30YSx67yA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 06:45:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:45:03 +0000
Message-ID: <10bb6ddd-d5c5-4907-a2fc-315d81857b4a@amd.com>
Date: Thu, 25 Apr 2024 08:44:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix overflowed array index read warning
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240425052736.1312063-1-tim.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240425052736.1312063-1-tim.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 38116e9d-c291-4c7c-84d6-08dc64f33c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0paMks4ajdSTzZYUXIyVkxtV25oN1FnUElPVWtrcVlVRC9ueUtCZDhSaHEv?=
 =?utf-8?B?R01pbmIxN1YxMy9RK3h6a0Y0Smx2QW1EdjYvQ0UxVGpxUjkxbmlCQktYQjdO?=
 =?utf-8?B?Z0NxdWlPRWRiRGxua2MzQ2ErekVXdExEb0xGQ2dqb0VML1FRRDViVXJrbXRr?=
 =?utf-8?B?MW9iRFZsdVlxVjUzT2dVblUzVHJteFNhT1FNaDIrbW9UY084TFVMN0dWTzFN?=
 =?utf-8?B?cFkzd2VEVVlKSzBDOEJWck9XbUxrTWlzTk01YVJpYXdCS3h6dmVvYWtZRTN6?=
 =?utf-8?B?c1ViSTFtNy9zOGIzbGFJdHZqb1ZacjI3NGlOM0ZlNFFpcEhINnkwVUlmSklC?=
 =?utf-8?B?Um9hS1BUVlQwTkxWbzJlYXdjMnNiOVhHS2g3a01Vc1dCcXNzNDBIUTJHNHlO?=
 =?utf-8?B?UWF2Wjlobmp6K2xpd1BNKzZUVXdOOTNpeDZ3YVRCSHVTMjFzZWJseEhBVXNw?=
 =?utf-8?B?OCs3Zkl6UkJsdkUzQlNneWJXWndIWFZzaTFQZlZqdnc2S1psaXRrNzBWSFZ4?=
 =?utf-8?B?WG9MaWhDRzEvMTlYc3p3TmtzU3hycnpxSFNBTjFHK2ZkMWhUajUyRVArMEFC?=
 =?utf-8?B?KzZtRzdHajFuZHBEdHBvRDNzRzNLWElJV1J0OWFBREdkVFZONlF0UmFQVnhY?=
 =?utf-8?B?U1ZxMTc3cDhNMWwveXRsN1YxazFRaVgxRVpOOEdsTzRLZ3pXMnIyMWJ6WEFP?=
 =?utf-8?B?Z2ppa3MzTjVoK0svMTl3aFhNamp5WndFRjQ5TVZpU0ZvTzN3WDlGanVIZEZs?=
 =?utf-8?B?NnluYVpEK1JhcHB1dVFHRThmOVVWVnVlek9uMHdyUWdVUklFcENLRDRTZ0FS?=
 =?utf-8?B?UGdaV1RabUljSXNkMGExRUNycDNvL201V0QyVWpEdS9veE9HRi9tYlloVHY0?=
 =?utf-8?B?UEhhcHlGNTJjbjh1VWRjZVFHYUNsV05nL1JsRWt1WTJoUmRQSkEyUy9XZGhp?=
 =?utf-8?B?V3lTazN6SWFReGFwRmNNamQyODREaHJaQW9tNFFVS2NiNmJTSkZrK3JDQ0lY?=
 =?utf-8?B?Sk5KeXgzQ1F1cGMzVjZHTS9VK0U3aGNhUWVlSjlrOGV3MFlVb3VpRGd4ZU5Q?=
 =?utf-8?B?Z0RDUlo3Q3laMDRUWS9Vb0RiUkwxTzFuaGIvdGRMcUgxZll1M05aanJZRUk1?=
 =?utf-8?B?c2JIZGpCWHg4ZmtEb0dSeTJSYzRVL2NFWkNCZzZHM25Bcm9NeUdnYzhxaVlw?=
 =?utf-8?B?K2NRL0RZSlhVR0RldHBDN2xKN1ZTQmdUVTR3RU1hcHc1SFdtcWNjMW1jWlpZ?=
 =?utf-8?B?S0N2YXJmVmNuU003NkRGSzZmUlUxY2NTaUhsbWZYZWhMcmh3bXppRmxQY1BJ?=
 =?utf-8?B?ZVg2OUZmV3dnbUhhN3FkNFVkNkNnV2ZGeGdTeUUxUGlWdnllTE5waXRUa2Vw?=
 =?utf-8?B?dmJsb2g3VUVEWVNvZnFPaWhTYnh6SFpzV0dWcWxMU3gzRVFHTGMvR2hnNEhN?=
 =?utf-8?B?VDRoWXNWdytPK1JJakxuUEFSaDVaU1hsZ3R3MnFTaGkrMjRnUTN2ZnJ4Y0oz?=
 =?utf-8?B?L0ZnZFpPaXJxclVPbEYvTE9OREloT2Jmd1hGdTVWcGNYWDBlR2VVUkxQd0No?=
 =?utf-8?B?S1BkQytyc0xnWHNGN0pkR1E0dnpxZGZEQ0VucURzanhialdZSVVoaVYxT1lN?=
 =?utf-8?B?TTdPbmNSbVpqQmpBTjIySEZiU0VMckhjNGhDUG40N29rZkVobG5jbXFnS2Yy?=
 =?utf-8?B?TThXb2tzMW10RnNxQ0NkOERYYUhFaFFNL016azltV1RVQ2szSDFhMmNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2pzb0tzbGhNaGZwSHczby90UC9IR0xMV1R1TXgrdVBiMWJyemFscFVOeTda?=
 =?utf-8?B?Wi9PellIbk10c3pCRXdTaVJRMFFPUXRrZ2pUMFphNlkreUxwRURpZHZKT1dQ?=
 =?utf-8?B?LzdYMUQ3b1FlZXJFYUxyYkd2Q2FWVWV2UjVJbkpOOWsrNUdESFFQSFZSRTk2?=
 =?utf-8?B?MDA2NWI1anhlRzhhOUxtc1RuMWNRKzdCamx6b0pRdGhMQTVteFI2WlF1T2hU?=
 =?utf-8?B?VThVTDNIaTFkY050RlR0SVMzR2loZnpScDBBZzkyOSs4eGkycWZkUW5yOUUz?=
 =?utf-8?B?NVdjOVczS0V4MUIvWW9TVDNyS3VkamZWUWdMMW9pY2t3eWRYNzkvSWNDT2lK?=
 =?utf-8?B?SWo1R2NFNTBIZHdTRnlacytjem8wSEJTUzhsM01OYXRrT2ZzaEVhemw5cG1X?=
 =?utf-8?B?YmttZXJpMWJJSFo1WVJjUVlYcmxhVG1VMm00eGRMak9rVkM0eXU1RjB2Z3Ry?=
 =?utf-8?B?OVRPS0pEeDNLNG9tbGRVSkY0a3lSRUtyeHZ6eW5DUnBzaFhTYnhlczAzcTN0?=
 =?utf-8?B?NnRFcDZ5Z05ob216OXJjdGd2aVdNa0QzOVJ6b1JYcCtCZ2lZTHJVQTB2aXQ1?=
 =?utf-8?B?bjZnZk42U25SemdnWGljZzJiT0NLamFXVi9yamVUVDZkL2FlM3kzTWtFeUNx?=
 =?utf-8?B?SGRWNUJqcUQ1MnFFejBzaklDRnhwUG9Ma1pOY3JKazZQd3JSRU45TUd3WWV4?=
 =?utf-8?B?K0lpN2gxWWlqM3FRdk5QSHBUejVpd3lRMVlLWmpIN0NhTlNHdDJvZ3M1eUw4?=
 =?utf-8?B?V0RsNWltMmYwcW5zUDZUc1pRRFRjT1NLb21QVlJkNmVDazRwM3l0Sld1ZVhr?=
 =?utf-8?B?VW5EMEVRaVhMQ01mRW1uSlo5dnJQN296NHdETUxVS0puTXdKaVp6c1kxZ0Ur?=
 =?utf-8?B?bzhYdm02aEFhQmkzUUE1dTkvb3Yybnh1SGZHTllxdk5FVDVWcDgyV0Y4NjNY?=
 =?utf-8?B?L21yTkZKYjQzazZ0WFRqMHpXSDdGYituWlFvUERCai92Z3FmZkd3Y20vazZE?=
 =?utf-8?B?SUovWjVjb1BGZlQ1RHA4N1NoR05zWFhuaVpJMEVRZm1GVitaa05mNmZtYity?=
 =?utf-8?B?NktkY3g5ci8wakdrYmJwUmdESHFkb21NOUlqUkY4UVFFY0dodERDRHMxdmVq?=
 =?utf-8?B?VHpTUll2REpGMkRoN1Evam13RkdwbnU3ZUVSNFNjWVZXRlJzM0pFNnlDblNk?=
 =?utf-8?B?Ulk1azZLbGtubmVZQTdrVEtKQ0JZUHVPaWxlWlV4U1hqYUZlelZrNFVnbnBt?=
 =?utf-8?B?blZVUTVEdWNGdmJxVjZUYlJkOVltMkFMSTFsbSthR0o2VVdOTnplTE5uZENw?=
 =?utf-8?B?U21ZSjEwQlM5SGR4ZUZlZXZjeE5aQkEvQW5Rei9OMHVtWSt4RnJXU05WVEJa?=
 =?utf-8?B?T05sVEZhZTBCUXdNUGJzVUpnMkFJY3AzZm5rMmRjOEYxTldXbUJlQlBXOWV6?=
 =?utf-8?B?T0g4K2JNMkFmNXlDRmdxN2VldUFNUTZVbWM1dmkyZVBieUpJaytBaFZaaDkr?=
 =?utf-8?B?VVN0YXNncEZUUkx2NUgxeG1sTEN6UW1HQnkrMUthR3NDQ0dDdlpWWFBlM2tN?=
 =?utf-8?B?ck0vZXpTVG5pMTdJeTlXM0lMRUpSNDBML0ppVklzZmhKYWlQeHViRTZCVXV6?=
 =?utf-8?B?a3ZJNVBNTDJJR3lTNDZ5Wmk5WmswdjFlYUxTQW50aHdtOVlYdnpvOFBwWm9r?=
 =?utf-8?B?N3ZPWmxXcWtDbmlLbGZmb3RjUTExNHRER1FiTkVQNklRQlZLZWZqZnBJYlQ1?=
 =?utf-8?B?OGhSelFpYmo0OE02WVcyWDdVZ2d1WjNickxKRWpacWpYVnVvaVVTdk5Yc3J0?=
 =?utf-8?B?dGNSeHZzcEpaNU9hdWNpQ1U3K3Z3ZkVzNldscTBEOHIrOU81b3UyU2hKNnRs?=
 =?utf-8?B?Qk5Cc3hRWFIvYk5FdVBXWlcxc3BQT1BBdVBmSHJRbXJyOGhmVTZCQmdFS1d4?=
 =?utf-8?B?WjhWVmtORjh1ajJ3TklobnQvRGZBVURMWlRKK0FETDJXTUJIVEVaOUN3NGhD?=
 =?utf-8?B?T0YvUU93SXJZMEp5aDZCVFpoQ0lRVFIyeElkWUNwRWZpWVBFSUV2RWFhTEZW?=
 =?utf-8?B?bW5TSDNLQ3lsWktzMVMrMHkxZ3NtU2JqTXcrV0ZxYjJsQ0w3UjY2OUpJWXhI?=
 =?utf-8?Q?bA6imKwfVcECf+ivREDcZQpI6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38116e9d-c291-4c7c-84d6-08dc64f33c42
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:45:03.3351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UumcvSMlRoZ0j5+S1aAh+ai2Tye6pEBIwyFTbS5cmvTcPrypYwBJ6+wXbuU/7Lp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
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

Am 25.04.24 um 07:27 schrieb Tim Huang:
> From: Tim Huang <Tim.Huang@amd.com>
>
> Clear warning that cast operation might have overflowed.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 06f0a6534a94..6dfcd62e83ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -473,7 +473,7 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
>   					size_t size, loff_t *pos)
>   {
>   	struct amdgpu_ring *ring = file_inode(f)->i_private;
> -	int r, i;
> +	int r;
>   	uint32_t value, result, early[3];

While at it please declare "int r;" last, e.g. keep reverse xmas tree 
order here.

Apart from that looks good to me.

Regards,
Christian.

>   
>   	if (*pos & 3 || size & 3)
> @@ -485,7 +485,7 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
>   		early[0] = amdgpu_ring_get_rptr(ring) & ring->buf_mask;
>   		early[1] = amdgpu_ring_get_wptr(ring) & ring->buf_mask;
>   		early[2] = ring->wptr & ring->buf_mask;
> -		for (i = *pos / 4; i < 3 && size; i++) {
> +		for (loff_t i = *pos / 4; i < 3 && size; i++) {
>   			r = put_user(early[i], (uint32_t *)buf);
>   			if (r)
>   				return r;

