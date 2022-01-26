Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1982EC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 12:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D05B10E912;
	Wed, 26 Jan 2022 12:55:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE77010E90B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 12:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEBbulRe9ageVH+1Nn//jaikJBZsaS+jWfj+fTVECD19x1kSykG2SlvIonF+/xqhByY2vO8AlhczXnIgryHZ9HqnfSrgKjoWXDqsfYa1TWsmYc0oxQqPG5on6fEHQ4gY+egQ0uusN2e/Pe0jYc6fryXjD4CQlT62VJ536zwrtn1MH/HdIVxe++exBOthu9XfGCJRxgh0GLI2MURTQU80UwhyhuPdKPHGpA8K4xumNchj4k35Zh+YmA8uk9CoJPnXlUxhbhulEidCuVNcaZx6z3s0JG3qUd0zJQpgwFh7GPkdDZUQo5551Dohlp42eh/XPI6uMr4Fj6Wdfop5QGIOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOGLJq5KzBF+iPLPjC8rgF7s9oholJtIc/5bO7gxSyw=;
 b=J360VWuHeOkvd9BcbktOYY53oKKHFguN9OVkj8Qt2/C219iymltNGhJv5Fu51IylxVu/vPFN8QhMbdpkIb+Dz6hsTVHk8NeAlhPr2aiL4/aROAs7752wic9Q86CWi2TGVVun+kmYTPGN9v1fNtlRObvuSj3spvQDdI7xlBLvAiWZGyKATS24WxX+GPY5kbs3k3GXHI5sLAgcx9C4h9C4vZvh63xEb6jpu4ZWcMJGVFSkrXB0Bq9T0ZQMCENQFv66jm/s4WdLN39oMYBVOjhVNQrDhFlG/7ine9KT6R1UPOxl3Fv3DePIAnULKQlEXJvUdjXA+vomvHrWvWxNh4c2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOGLJq5KzBF+iPLPjC8rgF7s9oholJtIc/5bO7gxSyw=;
 b=iVqH8q/qhqn1rdNrbpOvohxtBOmOn4r723VIoL6StJgs7vLbvXOWXy/KC/FjDC/swNx1qkOQtuqbKP43tqVvLDBvwYs5sJMReY1avrS9HA8ySfQrst9KQYIADA1H5I6wpb3NKXLV6N1vnzyWdX/B2KqGQtF7wBUQyM4Cyvo+aIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Wed, 26 Jan 2022 12:55:10 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%5]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 12:55:10 +0000
Message-ID: <fbf698cf-594a-2980-814f-dc66e576ad62@amd.com>
Date: Wed, 26 Jan 2022 07:55:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 2/2] drm/amdgpu: add sysfs files for XGMI segment size and
 physical node id
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tom.StDenis@amd.com
References: <20220126115917.60308-1-christian.koenig@amd.com>
 <20220126115917.60308-2-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220126115917.60308-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda88c01-246c-4322-d3fc-08d9e0cb164b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1241E727B1DAA490D58FF73F99209@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c32Y0CaNAqlTRt0dFO7+7ftF8tpp3UOsEY2kI8FqOR79cfZ8HzSd9pALshb7yi2AnRIwyvF8R7pHEymN9/cG7VYbOyjA1Dg8Gzk2teD8/scYd+T/HW+KMwrJ5fDAJH+Rxt2XlDW44/xzW2QozOde5IieSrj25P2OqeL3bMfbvNsQWVZEAv6ZzgZfX7wWEmo/Py/wl12aDzcF+IKnd2/etlW6+e2bs86Z4J6M6cSvUaoKG/c6ZAycfGiwBv//9gfEAo+LWCqMIyciXPVLavUkkcL9oDDxvv3iNgFKLpw9Tt5ShRxKqIQgqalo7KV4lsxBBIIXSrHCXHSeC2vHoI1KhLzWD+xSo5+zez67Z9hIhuSrLAvDMLoywnqXzZ4TnIqGIm7wbofMKYtFX6WfOd24qdzfJPcg8Aor6AudKrTjPjdTHrYhIFLHR+5oNgrxdO4Fn0KxpKMiBOYQxuZWbf/epdcVaHpHDCSgmbzcWvSWyLp/pAEQMXY+lyndAxVW9/+uRCdgo6F/QaQauqBCfZK2F1Xx1AY6j7w2uXXOfG7qhQVftQVZ8AwfNi2xxxusckAcvZt5VMNRIxvlexsnmoS2k9JLn5d9zAMbgvUnDKrK59i9/kuz0MbrtrJIXVdi7rOzIsZkiW1yWFBxx1Ozl+zV3RiPKggAf6gapcRm6GnH8uV5YwanzcuCSuxoYvLvFuFFeCvQtAG7aOhDjI01SYJOpViiotiBHPkzHbNqDEzEgUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(66946007)(6506007)(31696002)(86362001)(2906002)(508600001)(66556008)(53546011)(66476007)(186003)(26005)(6666004)(6486002)(6512007)(316002)(36756003)(4326008)(5660300002)(31686004)(44832011)(2616005)(8676002)(38100700002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGMzZ2lKSXpJeHdJQ1gzN0lxSHpKdlNUYmVMZU9FRkMwWnFjSmJkZWQ1M21L?=
 =?utf-8?B?eEtMZ0JKTFRkWUVzZGRLNUZEeW1ySUt6ZGExazAxZ1hIVm1SRGlqd0FmMUZx?=
 =?utf-8?B?dVR1UE9GUWZjdFVaMzY4bzY0TFFhYnJIMHp4TjlsbGZRTmFYdUZzUWhJZ21j?=
 =?utf-8?B?SEpZMUM5ZVZiSVc2ejVuOTMrMlY5eG9kT1JKZ3ZoODI2d1BWeHB4RW9RcEto?=
 =?utf-8?B?Y1Uwa25vUTlOcWpHWHJ6cWIwVzBnazYyaFhGUnBaVkFTTGFKdmdpY1FMb05H?=
 =?utf-8?B?b0wyNTNXQkNENW1SbjJtZXJYT0tWREZ4TlZmRWp4d0Q5ejg1TTRVQUdmNnJt?=
 =?utf-8?B?Vm1pc21UclZQUVo1NjNJTHFadTdLNlN0d2pneDFpOGJnU1l2L3JIU2I2b1hR?=
 =?utf-8?B?Vkt6N0daNVc5V2lmTjIzUXg3b0UvNzh1M0NlaENVbUg0WHpDSEhFelBhSHhj?=
 =?utf-8?B?MVlzVkk1aUVEaDhnN0ZjS1M0MXU1SFdtaXJ4NnJkT0VnS0k1cGszQ2VIdWUw?=
 =?utf-8?B?K1V1Rm1nL29UWTNoNTF0TS8rTmw0VlZtRVJnQjBIQ25VbFZSeHE2cjVNVFkv?=
 =?utf-8?B?VnhWWDRZSnM5LzNlbFA4dGNSMXVqMEpvQXczTFZRR2ZwNkhYL2Z3ZDZhTStn?=
 =?utf-8?B?VGJRcERWNGt4ZGVWd3c0Rlc1QjFUOHZxajAycnV3bnBLMkJPMWdQNWx2eU5P?=
 =?utf-8?B?UHRwQ0JKSGo3bXNqSE4vN01Kbis4cVR5amE2azZmNmJDcmpEd29QZWNkS3ZR?=
 =?utf-8?B?b3VhdnpZZ3liQm5IT01jRWFoTnVPRnJpTDB1cjVrZ0dyVHk1U3IvNXlvMXlU?=
 =?utf-8?B?ZklURjhGNEMydk1BdHd2VFRBVUlXZ0o4aW1IS0pGcm1nbWVUbDJXSkVTWVRz?=
 =?utf-8?B?UHNoYmNoTFBzdkZ3M1lTWVg0aG9sZCt5MUNoRlhicWxoM2JPMEFVdnBVdlht?=
 =?utf-8?B?aE84TEsyUnZCZzJPS3pGbi9iNzJQL3dhT0haWmg5U2M5ZzNxNDFQdUsrMGhH?=
 =?utf-8?B?UTQvOGZCQjRqaXZxc1JuS3RmY2Uxa1JpUyt3Zm42ZFRCR2RUbDhTa1FydFVP?=
 =?utf-8?B?N0dFNGNzZVN1aTZwa0d4Zjl1Z2ZadVd1bFpjTXRFaTIwY0l3aXJLUzdvaHp0?=
 =?utf-8?B?aDlNOHNkVEtacDRORkUrSzBOTG1LVFJKYXhCQkNZZkpKakhZcVNRWHlidEh1?=
 =?utf-8?B?eWRNTVBlTjQ3bFZiOXJacVNudXRUZTcvVEdoQTdnZU5GSEpvYWl0bFVuc0pa?=
 =?utf-8?B?TkZBUzJ0Mm9WZUNBLzNiYkJaOXo0TDJjeWtkbmROSFM0UjVsS1ZFTERDejd4?=
 =?utf-8?B?MkFpOG4yZ2lLbUxkcVVhSnpiS3FYeXo5NUFLQUE0b1ZIVFE4dWZEdU82bTJX?=
 =?utf-8?B?YXUrVnBsNEU5dDdUZzZGVHUwTXM0b0M3SFFTL1YyaytoUFh3b3RYRnJJU3ZX?=
 =?utf-8?B?US9pRkVGb3pUY3UycGtBQWhnd0lpc0k2ZkxaZWwzUmRiZW80ckpITUhyYUpp?=
 =?utf-8?B?NEZlRTZMSGFZUDZsQ2FOVExTcUpvd1JIakhFQUhtY3A2OHRBaFJtL2o0S09E?=
 =?utf-8?B?THoxZUZ6MDB4UEJqMVcxa285bEdRUU1QbW1tS2hMR2pnK1dFcjJWWUd4bFJI?=
 =?utf-8?B?c2lkR3hnTnlna0tsR0ZQWStYMHZSRFpHN1krZnEzZDhrV01Ua28wcG9ieStm?=
 =?utf-8?B?SEhZU1ZQZGNDSDNPeTFpQmovZ2FqV3p5QVVUZWhNS2p5bUtGbzFHNXFwZm9n?=
 =?utf-8?B?dmJpVWRwUTRUR3V4NjVpaWNDbENPdWQ1VE9XMERFZjNOSkhIbXlOQ1MzaUhj?=
 =?utf-8?B?UWk0Ui94alV0VmswemdqVUlITDd0MGU3VjMzR05aUkV1bnN3bHpMYk9TRnkv?=
 =?utf-8?B?Yzl6S1BaWnhBVXRQTU1FYldza2hkOGJuWDN3S3NVd1FOeG5LL1JhaTVLMDdp?=
 =?utf-8?B?MmhxUjNaNVdxMlBISm5PRVkxOW1ncFVzZTZVN0ZGSTFXeWpETWFPU2pVeHFJ?=
 =?utf-8?B?cTZBS0ZvRlRoaHlzbmFBbzYrdUdobjhwK296ajlqMWtleTB4dFZjemduMHhZ?=
 =?utf-8?B?TVMxS3lIMUZyVlRaeE9DZHB3blBQTm9sTXdHc01lR044dkk4bmNudHZIZUMv?=
 =?utf-8?Q?mpVc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda88c01-246c-4322-d3fc-08d9e0cb164b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 12:55:10.7936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOA8Bo8iSPKmqgnxKwvB7AXvUs24sgq/IGVmmXc4MVJ2WjULAgJY3ZK0dfCeYwE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This seems reasonable. Hope it works out for umr.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-01-26 06:59, Christian König wrote:
> umr needs that to correctly calculate the VRAM base address
> inside the MC address space.
>
> Only compile tested!
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 34 ++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 68509f619ba3..21a5d07a1abf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -252,6 +252,26 @@ static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
>  
>  }
>  
> +static ssize_t amdgpu_xgmi_show_node_segment_size(struct device *dev,
> +						  struct device_attribute *attr,
> +						  char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	return sysfs_emit(buf, "%llu\n", adev->gmc.xgmi.node_segment_size);
> +}
> +
> +static ssize_t amdgpu_xgmi_show_physical_node_id(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	return sysfs_emit(buf, "%u\n", adev->gmc.xgmi.physical_node_id);
> +}
> +
>  #define AMDGPU_XGMI_SET_FICAA(o)	((o) | 0x456801)
>  static ssize_t amdgpu_xgmi_show_error(struct device *dev,
>  				      struct device_attribute *attr,
> @@ -287,6 +307,10 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
>  
>  
>  static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, NULL);
> +static DEVICE_ATTR(xgmi_node_segment_size, S_IRUGO,
> +		   amdgpu_xgmi_show_node_segment_size, NULL);
> +static DEVICE_ATTR(xgmi_physical_node_id, S_IRUGO,
> +		   amdgpu_xgmi_show_physical_node_id, NULL);
>  static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);
>  
>  static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
> @@ -295,6 +319,8 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
>  	char node[10];
>  
>  	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
> +	device_remove_file(adev->dev, &dev_attr_xgmi_node_segment_size);
> +	device_remove_file(adev->dev, &dev_attr_xgmi_physical_node_id);
>  	device_remove_file(adev->dev, &dev_attr_xgmi_error);
>  
>  	if (hive->kobj.parent != (&adev->dev->kobj))
> @@ -318,6 +344,14 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>  
> +	r = device_create_file(adev->dev, &dev_attr_xgmi_node_segment_size);
> +	if (r)
> +		goto error;
> +
> +	r = device_create_file(adev->dev, &dev_attr_xgmi_physical_node_id);
> +	if (r)
> +		goto error;
> +
>  	/* Create sysfs link to hive info folder on the first device */
>  	if (hive->kobj.parent != (&adev->dev->kobj)) {
>  		r = sysfs_create_link(&adev->dev->kobj, &hive->kobj,

Regards,
-- 
Luben

