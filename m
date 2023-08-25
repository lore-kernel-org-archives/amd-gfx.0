Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CACC71133
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 04:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D571810E5FA;
	Fri, 25 Aug 2023 04:21:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5009D10E5FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 04:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaWSbbXmKRQaRpSsUHTubwIPXuS0uZAR2GJuhtQw7xDyx0ItvrqPr90tncUT/9ebGeM5FURocn/YLwgK9XnVceOlboPiAXOtZcHN9gd7LFc6y8H/D0PcSOZ9rJ7EUGcgqwMaeFitZzwPYTsROpjd+O/GdQnQmsHemIzrhhlzvQNkKrZQ0mtJc7U/w/jzvLr60zwvggm672faRHSZWH4CAxyWkeinfHVNTqSFk5Mh/0DeCIkuovtiq5GTS55VqbUXfttxpmRTx64k5GnsDrjmx17R8QSSmRQlOeUjMl/GFNUyjdPy4Yd+I9DWSCOQBSAwuUZrNwccgpxVY3ilq7VQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/14p5H/CXu9mcmgMVyoSyTslgRYkdRRAYDpb4EWQBjM=;
 b=DDPZiz1m4rn1PUDMGTH8L/HE8dkQEclkyRvOpzY04CJPOsw3IirwdbMzV01L7SkcSs9OK9r0dy/mcLk1gA2CnzaGYu+fe1oqn9X6H7c2+0GMLHGY1NnY957RB71/nGd4vr3vduRgm37g7Ghr5nwtXkWHDN1ECBZDmm3yHiUIJbG5uHSCI3gnIubzf8CK0n+W3MKHT+Ne8MugcwhYonU3ny9PqGAUlgcFB2ysxo4R55IZUMx8xEkdWl0klDYFAz3TlGa8tALg8uLLZEIjFr86PGXJPmSQd+GN4z3QzSVF3aWWnjJC/nkw6sREooKbY5+vUGyQ+5zKBKsLBMIAsMTGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/14p5H/CXu9mcmgMVyoSyTslgRYkdRRAYDpb4EWQBjM=;
 b=ygOtFWyXGN6oZcNN1j+a9lAhtyUSxeB/V3oA1OR+57sZJvvKk2WrGjT88dO7LxPMmh0UnCyF1vRXFejMY24mxAWT9EXc6X1D8cPnwbFialCE7LIOnxLlrNR1RsB3MrBNdth0R4EM217Y1rOJKNSCWTb7C7xd013aPSbkAzuh75s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 04:21:05 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 04:21:04 +0000
Message-ID: <d063b647-a980-9b85-63d4-5bd7bc4613e0@amd.com>
Date: Fri, 25 Aug 2023 09:50:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Hide xcp partition sysfs under SRIOV
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230824152329.12276-1-rajneesh.bhardwaj@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230824152329.12276-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a55c3f7-e36f-4aa8-ae04-08dba522b21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SN0diJJGaNSpRI8iVUzmRCHVUlmfxdCKPBu6xbl2aRC1Xy65/myQ9lKQtCKu34RNQLxYpsD7WivSpiMpK+xpXZcPgN+RKaBsUlcDGrPedtdSewBB6YSJw67YDUfg+fXc6EjZbrtl4X/5+ej6HTrCf0f2NBKbHfezC+YbAaAv7VZWXkO18MwU50qkDoFJfL2HCt3fEcZiKKFSeT+SfmV8NK1UFdyOuiSNDl1R2cD17PctQJXn2j/JUYwiJO56PQFPVbqM6F2wAchH2alknzQ01EjY4pkAc3EQ4J8fIGtbQuqMK2m+b5OgB5e+2dmDxzIV9vcegWTsuNESKPkjN7pYmZ74IH9fnLBVKRUAZj5zNl5iif3zOvTwS1L+BORwXOVtxtUSrXtq6ONysZ/1H1lZqiKwPZXF2vBrOFgCwrQgtRmqzfnyGHOvoc75IOM0pDfl0TE+yzECgMl0GRh2r0Ol/AUyKCsaEOBS+TZ68siBaFcedQKYt8grb46f6wyHJjnfEfrZTE93wKvOcLaz62SiWI5mx6sHahPH+cvT1wwyQlVYru9SnduTU7rPahUkucUY/c1Q1ViFIswavV0K+jacZU+bBIkJeccyxV4QKjsl8F4msv/u/AMV3SzqZiI/vGqq0wGrRo2+87A3LwPNg/DcAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(1800799009)(451199024)(186009)(83380400001)(6512007)(26005)(478600001)(2616005)(5660300002)(31686004)(2906002)(8936002)(4326008)(8676002)(38100700002)(66476007)(66556008)(66946007)(86362001)(41300700001)(31696002)(6486002)(53546011)(36756003)(6506007)(316002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjBWeVRwTjRlQXY1VktFdHRXUCt3aGg2d1FQUFZGRHZ3YTdXRnBPY1Ntc083?=
 =?utf-8?B?MnJrbjRWemJzaENLSDNIbVFjNUtGNXhteUZuMDR6K21odWdSeEFubUhoT0F5?=
 =?utf-8?B?SUx2OWFoR2N2aEVkenZIMloyd1gxZ2QyalVzSFlwWW9mb0NnNytKOXpjUmdM?=
 =?utf-8?B?QzJ5UVQxb3ZBUE90NzZVZEVFalNGOGRDQ2lEM3RqLy92enQ2c3JRNHNKdVFj?=
 =?utf-8?B?Q3JUcmpjS2FtY2MwK1FoTUZ4czBZak5QUHhGT2FaZ0QwU3BXTEw0cGcrWmJ2?=
 =?utf-8?B?czV0K3Y4OWdtNzA0K1AxRDVad29LUEp4T2ZTNGpQSjF3YXBoeGwzbnJ0K1JZ?=
 =?utf-8?B?TnVoNnRTZ0RVV1IyMXdKd2xvWEZWYkZ5ZWYzSDNqbXpIcHl1WGRIa1NaNzJV?=
 =?utf-8?B?VStWZGVNbkh4Z2JOTEhUMURpS3JjODJVaWZkSUYyYnBhdkhmc2tOd28vRk1O?=
 =?utf-8?B?TmJqWm9hV3RqbmtENDhwcVhId1QwSFY2dkRTTTVDRGtKeUhqUFdTUXRGbmhh?=
 =?utf-8?B?N2luYzFOMkxxT2lET2cvZDhLNDkxRE5MVU5sVnV5MUpkcStaUkw0b1NKcFor?=
 =?utf-8?B?U2JPQzhXTllERXh3a0hSQ1RRY0Z4Z2sxcG1GeVRIeXRNbzJUUkU4cDVjSUtT?=
 =?utf-8?B?MEJnZjlrcmZqN0F3U2h6bmhGcG9iUW9iS2EzUC9zVVVHUXU2WnI1RkdPclJk?=
 =?utf-8?B?dTczcG85bjZjVlBNT0w0UHdtUng5U1lteUszUW9NaHVmelkydFhjTjZGVzFN?=
 =?utf-8?B?VlRlWlBrNUlWMUlwcm11bnNnc3hVa3JkeTRvY0ludjhZeUdrSW1teTkyaVlS?=
 =?utf-8?B?NWRrUzIxUjBGOE9nMXJKaXpuM012N05JSG9vYVU3bS9lNlhFK3MvemtYbXdO?=
 =?utf-8?B?UXJwNjhZVmhxSitELzNpZ3ZVbERFODMwNVFvMjFRZzVPMzNUM0QwdEpnaDFR?=
 =?utf-8?B?azZoSUZFcG1sZHhFbVB3MC9sdUVqQWFsdldHUzVyZ1dmNkllcDI4ZGRiY2lH?=
 =?utf-8?B?enMzUDZZYnJER2prTlU3bHJGdGt3QVRuNmFUNGE0Wk1FOWdzdzAxcWRuNElV?=
 =?utf-8?B?TGtMQTN5MjArYkdQRjM0WEtMNUpUaVNlb0hIa1hwZk1RQjBZYk44V3RxbHRV?=
 =?utf-8?B?dlRzWitCUTR2akQ2RTBhYXJiMnZHVEg1UnFjMkVtK2xKMXpBSUhiNE00cXdj?=
 =?utf-8?B?emFEaDB5c2JFQi9pTHdobnVyZllDc0RncVRlNEhMdXJMOHNHYmMzVWw5cGNp?=
 =?utf-8?B?Q2ZMdGZmU3BrdnZ3dzhUYjREUjJzSU9MUFhIZndyeldlb1BOamVwTUdKQmxN?=
 =?utf-8?B?Q2xIK0pOc2RCWG5XWlpFVDh5Zko1WnVQek0zR2RUMzJDeVIvZXM5eDVyOUJw?=
 =?utf-8?B?RDdYaEd4S2xvNVg0Y1phbWczZi9zRENJNEc5eVl0N1Rsb0lFVHpCdUVmQ2NS?=
 =?utf-8?B?dXhOQjQ2WEhJMlhxYmNwVW8xdHErQVRwd1VVUm1qeTIwN3hIakRCRXpER0pQ?=
 =?utf-8?B?OThBbnoyQnVPS2ZJVitFMW1iRnNFUS9GQkNqd3FudmZjdDQ1VUdlTTc3ZGVn?=
 =?utf-8?B?cmMwVmFqbjBZNlNWSWQzRFltQk9VNk5WVlFkZFdaUmdVOSt6MFJzaFFGRzMx?=
 =?utf-8?B?K2VZOXhzLzI3UklBbzBsS3lTR0pDWFdLOUx4Q0ZBRnNRRGZXUUVqOUQyWDVM?=
 =?utf-8?B?T1IyeFBFaDcvbU5XN2F6VzlGVlRBdlJzYXczd05pY0JpTHFyazBnREgyNkJt?=
 =?utf-8?B?bHA0a3JsUjVYZ0pEYTJuWFFsM1RiVUx2OFpXUFZadkRLYkE1RTZkZmhrV2tP?=
 =?utf-8?B?cHAzUW9OQUd2dWxmRURrMTkyUDA2S0szSUJPVzZrSlNvWUptN0ZDM0RJQWpQ?=
 =?utf-8?B?aEx2Nmo4ZEpnN1poekhBNkJNYnEvbHZ5bjhVNFRiMy9NRk9CYm5GdEpRRCs1?=
 =?utf-8?B?Y0xSaWltVFJ4elhuSzQ3cWxOaE53STNKU2c3NkVlQ09CQ08yak1IUFpPNVRV?=
 =?utf-8?B?ZDZkaHJFaG5VR3Q4bkorU0M0NDFQN3hNTmVUNTBmK3ltWnBhOG9BeU82NEVH?=
 =?utf-8?B?b1NjbTc4SXBrZUJ0T2NYSVZPSEU3bmhHd2IwVE90ZEdwa1paamZWcU1GNHNB?=
 =?utf-8?Q?j0IrRs8eh3W1liUIoTBwGL/7O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a55c3f7-e36f-4aa8-ae04-08dba522b21e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 04:21:04.3086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/7n6Nm07P0sVVaBJtDESRlQRaVRygQZbd4oV64vgeL9wjRtt0PTykc5Tmwyb0Xe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/24/2023 8:53 PM, Rajneesh Bhardwaj wrote:
> XCP partitions should not be visible for the VF for GFXIP 9.4.3.
> 
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index b4fdb269f856..b1ca3014a9e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -863,11 +863,15 @@ static int gfx_v9_4_3_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_gfx_sysfs_init(adev);
> +	r = amdgpu_gfx_ras_sw_init(adev);
>   	if (r)
>   		return r;
>   
> -	return amdgpu_gfx_ras_sw_init(adev);
> +
> +	if (!amdgpu_sriov_vf(adev))
> +		r = amdgpu_gfx_sysfs_init(adev);
> +
> +	return r;
>   }
>   
>   static int gfx_v9_4_3_sw_fini(void *handle)
> @@ -888,7 +892,8 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>   	gfx_v9_4_3_mec_fini(adev);
>   	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>   	gfx_v9_4_3_free_microcode(adev);
> -	amdgpu_gfx_sysfs_fini(adev);
> +	if (!amdgpu_sriov_vf(adev))
> +		amdgpu_gfx_sysfs_fini(adev);
>   
>   	return 0;
>   }
