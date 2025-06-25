Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C721C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 07:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18AD710E67E;
	Wed, 25 Jun 2025 07:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x76OHzj9";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92AA10E67E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 07:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOXaqGTATffuM5R/Wkym23qk0RB5C7tkFRI9vGz1XA7bQ1KsO2fvd1Q7YEH2obYBzVUQ0PztL5w5/oU0bG4Lej8DadZ50xsVeXXAYLIOwT8xr88q/cY/F5PhK7pSG4U5MVg6hSLZa2KFIWDjCh98A8gWwWnmGQ80u8IL2BtibscY3ZJb1PIMOUJcz2MCUPZ3gR3aVfMI6734cOCg9ZHdLMdha6HbUIvCbFbzLmfSYXrcsRitN5TKJRVFA+IjapGR7Zwi37fDihDoCiv1AMrTWo18fkLzex9ZB8AgsUMqD6UOLgmMzZoyC4Zhdl/jwjFZm9kiFHRVQINmq5tUdurAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8iv1PEfRJIscSqiu9NlfCnSw/gzpKRfiy0/zZChXgw=;
 b=MCXEXH+2kCZnBQHtq6ITfmi+88oCFt+D7986lZl9nmo99VaQhXkoz0yXRX7g9v244IqpKdLP6MCNXn4vpSiqyNA5PJVHzA/xu2RO70/46EIbozlOrMaZDcZthuLBf/0mRhx5l7zy3MlW7cmo4Wru78RxPadFul2utRSji9ygwvNI9u9VNZT27QdYpGOQ3B/B0Me7cBXmPkaFmO5w00kjpOGBlf1WCIJ4vaMQTIMXMxDqXsbjHt9UbQyceTxEcfDUMe9AB+5v4h0JA4lG70CgYBYBlc3mWDnnd8gHI/1JYFAtC5JnUaPhUwweFzYdYrk5/M9ly1/hTcWfWlqU+zHqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8iv1PEfRJIscSqiu9NlfCnSw/gzpKRfiy0/zZChXgw=;
 b=x76OHzj9IGq6xFc4PvzWWRgsQ6tlcf8KuI223mwq5N59vNicb4z6A9w5uhF475uADIpLXvXGA74ZHRSM0F4B0LWTmQ2LuWy2XX+WU9p9QQhyPmLrPJgIJ1LO28AVKz0GYokbC0lysyZ0O1GX5vg2oRvlK2rGlvqccLJmSsXTi0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 07:50:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 07:50:02 +0000
Message-ID: <95e86cba-b3de-4f42-bd47-6e7eebcf2acd@amd.com>
Date: Wed, 25 Jun 2025 09:49:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] drm/amdgpu: only bound the eviction fence to
 userq bo
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-10-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250624084535.1178476-10-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: a59f1e9c-17d2-441c-8304-08ddb3bce464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWRjaDVneE5RK05xaGJwb01CS3paMnJjUjVVajdPdyt1eUwyVTRhcFVjNE1P?=
 =?utf-8?B?dEp2bzRjN0MrMUx3Y2VlaVhNYmQ4c1pCZkZwN0svMUpTM0ZlTmIxTDRKZ0J0?=
 =?utf-8?B?ZTA4bmZzakJNbW9oMmdVVmE0ajVUUmFEczFsZjZoekt2dHk5c0ljczh2UzFI?=
 =?utf-8?B?RkhSY2o1a1ZPRlU1dzZtM1N6TnA2TndwbUo0dENzTTdtWXJTN080VU1lZEtR?=
 =?utf-8?B?bFo1QUNIdHNrTlM3WDVaM3VOUmhYV0tYa1J0MllMYzhwN2k2Sy9JUkl5dW9T?=
 =?utf-8?B?cDM4UktBQVVWVXRDVEgwSTBmbmxTS2JQSHpZeGJ4VW9KcmtCcUR4MjJVTVFp?=
 =?utf-8?B?cHpEWnhPd05UZlRWbUQ0YUlyTUNWam9reFE1M0xUbjJ0dTRUSUxiMlQ5VzZr?=
 =?utf-8?B?N1IrajN3VDVSZnhqNm5hREYwb2ZnRytiTVFIK0hLMmYxUVZJNGR6ZlltSTM5?=
 =?utf-8?B?cDNySGFubDNXa3FqQ0dPZG8vNWlUVUQ1cWQ3ak9mSlZjODdTcmhRR0Zxb2dB?=
 =?utf-8?B?L3VNYmVKWWlubjBXRjI0Y2xpUTRYY00vZC9Md2lNc2duOUtadTJkWGxBSU9T?=
 =?utf-8?B?ZWJKOUYzd1hlY0ZVNDZJSUtURWg5SFhDb3hiN2xIQnRUUGRJS2g0c1gxa05S?=
 =?utf-8?B?SHlLL3lpM0x3elZXeEJCbEVlV1FGcGlJVzlFcFdEV3pBOFdNbklYWG8rL0xi?=
 =?utf-8?B?VVVKZHJ4bTkwU3FSMy93NjMxajMxNEZCN1NKWUxLM00vOXo2RDdsR29vREUr?=
 =?utf-8?B?VnFBWS90ZEZaL09EazhGODZidGlOaHp4WDJyR1JzOU9LZ1RXTEx1ZXQ1MGR5?=
 =?utf-8?B?eTNrTWV2RW91aHoyOGNKNS84RHJ1Wis5eWQvRkJieHkyakZNR0poU0tNQkZJ?=
 =?utf-8?B?TW9ORTRVOGwrS1JLVHZLTk85d1d3M2Z0YUxOOUx6YWs0VWRJZzlBRHFtaCtZ?=
 =?utf-8?B?anorVkd4YmpiT1hOSWRENzVOUElxTGd2RlFrMmN4cDBTSkF2UGg0dDMwKzJW?=
 =?utf-8?B?QXBENEtwRWhHN2gvWmFUc1pwd21EUU1ncFMrUmlsUnZucjYwcjNwSllsMlVj?=
 =?utf-8?B?LzVnMjMyS0c1RUlZNzEyV3lBdGVMMmtvQXpvS1lPdEdCbjRhZS9sZHNRMXFo?=
 =?utf-8?B?VzcvMTFPOFJydFdtQmlRTG5CNnRJQkhmbU5RdmY5MTdtNEFkeTJiMm1RQno2?=
 =?utf-8?B?Vjk5NmMvYUJtcHhnTC9KeFFkclRzczRZdTkvakV3RDErM3hvdzhVZlU0Nno4?=
 =?utf-8?B?Y0k2eFhNTG1rNW5xcXNyanRTMkpqOHh3azFXU0V1ZzA1UWF6eXR3czVtbnRI?=
 =?utf-8?B?UWtUMzlxcy9ieVpQZTlTWWMwbE5PUUZ3Qk1TOU9FSEcyUWZFdzdGeVlzL3hQ?=
 =?utf-8?B?djhsUmk0LzhUbnZtY0Z4QzFpQnE0T3M4YUJSZ2trRlRmT1pYaXlMMlhpRHlo?=
 =?utf-8?B?RjhzS3lZbG1tVllRTklWaEpVd2JWWHpON2t1R1JmYW1pSkh0cTQxS2czRllx?=
 =?utf-8?B?YlFUZFlvNEtBM0k4aWVSWnI2TnNJVU90TnBqVDNnR082ZHI0ZjhRcWsvZFoy?=
 =?utf-8?B?TGVNVGgvbzNyazZxaE1MSGJyaE5EdVJJZ0JjSktsNXVrZFV2QURZZjgrcGVB?=
 =?utf-8?B?Q0ttTGtQUERUVDVtWWozTUNjeDh0dkYveUpqR2hhUzVtT2NOT1UrNlR3VjdN?=
 =?utf-8?B?S3htSW1PeSt6Ykc0VTZxSnZqbUc5cmEzRGxNN2VieTBrWTBnb0F2amxmbHd6?=
 =?utf-8?B?dXlPVEYzU3A3WVY1Q25lSmFDd1MvLzFwQW1uRnNHS0tBc3N2YmoyRUs3TWdL?=
 =?utf-8?B?QzVyWGJTc1JWSTVEek53QWhwdjdzd1FacXRkOHZuOG9CUVkzRW9BR0RabXZi?=
 =?utf-8?B?MTBNcEpvaGtSeDU1VDhPS0laMy9NOFdoUXh2dDdTcFNXdnZkMmhGTnBWMVQw?=
 =?utf-8?Q?B3nl1QEwYj8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZDU0UzWmZPMUdDUjJYa09vUFM2bGx6Ni9FRjJIREQyZ2w5Slh1QldXL2Ex?=
 =?utf-8?B?WUdDQ2IzbnhsUUlzQmlaOVRqS0hLdFJoblY4VTNFR1FMcXdDSjlSS2g4Njdl?=
 =?utf-8?B?RkJTMWgxem9mUkJXWjluNmdSd3JEcEh1dnArNVQvWXhKdnFlVlRLSkFndDRO?=
 =?utf-8?B?OGM4bWszYzU4UkhpTFBrNjJoT01zd3dabXZtb2RvLy9LM0t2VFFWSTFmZVRN?=
 =?utf-8?B?Yk5GTGJjdnVyZGliQnJXVitlNmxBUVpGdlJRU0pOZWdBd3BvMWFJWU1VeUln?=
 =?utf-8?B?WTFTeHNFVXhKUWowUkFOMEl5N2NycThwMkw3SkFIMDlJazg0NklYVldVZE5U?=
 =?utf-8?B?ZElneWNpQ21GQ1ZhRWpLYUJ4NHdqWkFzNEFwUk9FSktSbXcyYXh1WDEySTV1?=
 =?utf-8?B?ZHJJYnNZV2tpRDAvVzRuQ3pDTGlpTEdPOFpSL3lQTHlUNDBpZm5hU3YrRlRJ?=
 =?utf-8?B?NEh1QjhqMlAzd0s3R0pWckpQV2d2QjFkNVpBWnhFendOeWExVm1CeEdsS3o2?=
 =?utf-8?B?YU5Va2xKTXpKWmt6emwzWllEMmc3bi9uNzkxTHF5b25xU29aZVR5MGlzREFN?=
 =?utf-8?B?TGZNbk9MQlB2RkgzakJPVTA1MHFpNGxwQ29xUDF5RVZsUlBWVE1OTWZoaWlK?=
 =?utf-8?B?MjI3cDM1YVdvOERGMEl6MUN3bWt1T2QwMUhoTktETFBwcEtLQkdWVTQ1VWlP?=
 =?utf-8?B?a1k3Slo3WlNwUUduQ2ZmQ0t5b2xVY1dTb05yNXdJc1dlMjJsWURuZ1dhVWp2?=
 =?utf-8?B?SWc3aUtYU0tEbzBmeGxENTdEcDdIVnhPOFJXOFBEdzlqYUg5U3M2VDh4aDJU?=
 =?utf-8?B?WVZSOVZjTjIrRlc3Nkh6SGVXejdybC8wQldNdW9WN3h4eWxJbUNMRFR1b08y?=
 =?utf-8?B?N1FqaEFrN0tpMG1QcHV1MGppeFc2WksvRGVSMWZ5T1pRNzFTbnQ1ODc5MnZR?=
 =?utf-8?B?VlVmcE5SaTlIdkVHWjdpdXljeDViek1aSWtpc3luOTVkTGZEb0hCRkxXQnpY?=
 =?utf-8?B?YWVrM213NG5LeXY3bGRkSVo0UFhVcmMrZWg1Z092d1V6VU9ycTdmVHE1b1Qr?=
 =?utf-8?B?c2lXV21OcTQ0Y21tVk1uVWgzTzZDcllCdlRSQldJYlMrZFlwRlltcklLM29a?=
 =?utf-8?B?VU1YNkJwRHNZMXl1M05wMWVGRHVtZFI5aUM0T3ZrVXJKbEpweVlQYkU3VGVK?=
 =?utf-8?B?OTE2UEtEL25YYzRSSWJQbkxZaGFhNUc4VlZnVUh6SVQwYllOeWJHV2NUMGxO?=
 =?utf-8?B?YS9ML2RXZWxGTnVZdXpYT25uOVcrd2JlRnc5SjRLMlF4N2xOVUlybGtSNGw4?=
 =?utf-8?B?OUhmNVc1VVljalQvV2g0Q1hVc0V4TCszRW1BRkJ2dVYvKzFCZHpndDE0SitQ?=
 =?utf-8?B?MDJlUmY4ZWx3UmNYYTdIOEdYaldTVUw1cVl3bjRkS2dHb1FZVWdVRzFsYmEw?=
 =?utf-8?B?ZEJQekt6dUFLQ201blRTYm82U1U0MUJUcGx5N0pmTHBPU01BQ0tPdWY2ekVT?=
 =?utf-8?B?ckplak9YakhrSk1rRVFuQm53UXlJNDdqZWoxYnlKeDN3Z09jdW0yRktvcTdL?=
 =?utf-8?B?SGlWV0xsa01oS3dZMGluRDhOTURyeWZmU3hFZkM5TnZ6ZEZ3YXJBZHdVRUxp?=
 =?utf-8?B?RGZMdjJ2bXBLQ1BmMXdCSFA3a3pTS2pTbE94MzQyeU1jeTUybGhJK092L2sr?=
 =?utf-8?B?U3JXMnlLeG9ySGs1RDVGS0RUVkZMaERJancxSHZGREJkODcrS2pSSnAxeU1F?=
 =?utf-8?B?QS9ITERQSGxrZGxDK3NtV3NFVGdvaVVSVlFGL0J3ZHJGR3hsc20ySU9MN2pC?=
 =?utf-8?B?cUFXTTJvWVhWVXVBSldncnFQc0liRlUvWHgyMFBzNWg0ZzV4ZTB1MkNhUWts?=
 =?utf-8?B?S1N4TjZyVzBVQk5qd0FIc0w3eTZYbjd0S1dCTmdHWDlqeTZ2WXBHWmFSY3p4?=
 =?utf-8?B?WGdMOEt4anNPczZMc3ZtSGdEWnROWVJpMGRFQmc1RHMrdllZeHVFUk12d0pH?=
 =?utf-8?B?ZFF1RGFQaTZKUXhYRENvZE5lMGpBb2tEdFFkT2xUODE4c0R0YVdnSGZvSEhr?=
 =?utf-8?B?ZUdzUkpuL1V2Q3pGNmdvT2tDUFBzUEVmUXVvcVk1aXlZUGRTc1VlTEdQeUhu?=
 =?utf-8?Q?oHNsP3PzsHqV4JZ+TQJv+thWU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59f1e9c-17d2-441c-8304-08ddb3bce464
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 07:50:02.7513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rI355uVv1MiBeBOZfjRsRNeIGwcee/3FJDliiWeBUSnAwTiL+Uj2wCOv9rZKsQQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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

On 24.06.25 10:45, Prike Liang wrote:
> It doesn't need to attach the invalid eviction fence
> to non-userq's BOs.

Clear NAK to this.

BOs are often created before the userqs are created.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 2c68118fe9fd..50356aa23a99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -294,12 +294,14 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>  	else
>  		++bo_va->ref_count;
>  
> -	/* attach gfx eviction fence */
> -	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
> -	if (r) {
> -		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
> -		amdgpu_bo_unreserve(abo);
> -		return r;
> +	/* attach gfx eviction fence when userq created*/
> +	if (vm->is_userq_context) {
> +		r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
> +		if (r) {
> +			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
> +			amdgpu_bo_unreserve(abo);
> +			return r;
> +		}
>  	}
>  
>  	amdgpu_bo_unreserve(abo);
> @@ -365,7 +367,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  			goto out_unlock;
>  	}
>  
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> +	if (!amdgpu_vm_is_bo_always_valid(vm, bo) && vm->is_compute_context)
>  		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
>  
>  	bo_va = amdgpu_vm_bo_find(vm, bo);

