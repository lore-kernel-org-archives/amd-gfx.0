Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086AAC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 10:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9436A10E397;
	Thu,  8 May 2025 10:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L3osqiF1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA7B10E397
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 10:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3ahvyWC1C1BO5CuEQmQNRi88Xoyv0ipX8jmyqUMU3QX0QLIQqvCvQ5Wd98VAzazTl+1jEtCWqXwTujZNafG1x/vys99PzDOdnHqr5+Iy6mvEYCW8BvWDdOV0jcnHTmpzGNG/D/z0JBpiw2SlYaB+2j/DqppQgs78Z17zwQgO0Zk4rg/VKsRLQcGYhNV6HYqRXHyKl64fW7pZyVSnbZHGgkj/QyvIm/6KHHcIvzpwbYNLEcTr6RuSdHElS7TPqwnVAveBwFlSRB8nPPETvYZNv1iYkqesIszXaGgey0mPp3LN+QeJKCIl/PJDeeu1IP9OVr7mTbXTaaoBIOa0IRUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DV2BwIK7mUgLsBhgTeHg0dw9SDN+i+zNxfEGvioiBw=;
 b=Nz3KEv72BAuMeGyjPUw/mT1m5wgDzOgJAn5YikECj0MdZVLAlvUUvakeUsFoPbYjRvfP2BvkPPF9oJzFGa6Y3Dv/XqDJ4/hBjPuxe8meGl6JbvrBqBzUHaEkgb7Jirs424nCLuFCsjy+TmqIejgV/kT3tiOcM1x6hd+oDutB/f5/FWHhCucwCiXlFrKRFYvKrWy+C4TcwfxMzqpBFRtyyWw0bEtymElbEVcC/dEYxsD4War8J9Q6HwwoRPWjBBzLz9oe5KLpRRT1KN1ddL7r6HkAoa1Pr+K+uaH4ZdlXdfllzvYVCsqWTuZ5Fn5UlpIuUwc1B5tShe3IrO7KoolEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DV2BwIK7mUgLsBhgTeHg0dw9SDN+i+zNxfEGvioiBw=;
 b=L3osqiF1mhXdIVSloRXRIJaShDIk5ZfLP7j9odY/LJ2xouQ5UNEdPdxiK5tnY6FJ8xY0se/q/i3J/hNJtP9bBMZyzZTJ0nxSPn2He06JPsBaun+d/zn8Mjwl2ngMMbJCpWUiG0q+7Hja+HCCbXZOtvQGNh0G3cmbuHL71lD49UM=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Thu, 8 May 2025 10:03:13 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 10:03:13 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, GuoQing (Sam)"
 <GuoQing.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Owen(SRDC)"
 <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>, Jiang Liu
 <gerry@linux.alibaba.com>
Subject: Re: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
Thread-Topic: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
Thread-Index: AQHbv9d4XpAdzZw0iECS+FEC5WeubLPIYiSAgACkXwA=
Date: Thu, 8 May 2025 10:03:09 +0000
Message-ID: <055a2062-699c-4f4c-822c-17fed6c982c5@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
 <20250508050926.228674-2-guoqing.zhang@amd.com>
 <1aca1130-082e-40df-83fd-eb00fa3ac206@amd.com>
In-Reply-To: <1aca1130-082e-40df-83fd-eb00fa3ac206@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DM4PR12MB5937.namprd12.prod.outlook.com
 (15.20.8722.017)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|CYXPR12MB9386:EE_
x-ms-office365-filtering-correlation-id: 4590bcc8-8218-401d-5895-08dd8e178b8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cROw/0CCsYL7s1cPTNdglmhZsUsAxJIiReEf4nxeFVzvFbXnga5ljH2GKS0X?=
 =?us-ascii?Q?Hzh5GKiAa6Ana4kGEI0ybEeaxTdW2gEOsb5R2wMVRDzosdcmthopEPDf8jdB?=
 =?us-ascii?Q?DVHU2/cpcIN1tyY1VN8jtUHLKITQ1Xvkyc09j9TU21oLx/9W9h1jgxJbkzHd?=
 =?us-ascii?Q?5694fdBl8KNmCplv6cp24x/MgG7KfdRW1E2MFaedzjW3OFEysm6OkCOMFARC?=
 =?us-ascii?Q?QP3AqiEzfzcIA4lKyqtArYRMIHUQybJgDl5bmVfaw8Jrxx86zeTwXnpqFssx?=
 =?us-ascii?Q?gEwbSZH53UnyQk/D2HAtpS8PmuIrZQiHWP6xPhMhOeEQCJ8pFFGmJpb65vMi?=
 =?us-ascii?Q?6COG1sXZnfd+tJdE8ecYTx9YfBi4QO5q3xAN6ZZiDrTTyR+yVgPoCsU+qY2P?=
 =?us-ascii?Q?e5Xwigibu9zyqoVUORDuworABGRMVbRKIFgmLO0FcrFrbjHGQYaKmGxSxJjd?=
 =?us-ascii?Q?G+VpRvOoVYkd6kyRAOCPIeKMwq1+evYokIE1oE/omBzJsm192OdF32UuycV3?=
 =?us-ascii?Q?bRJLE6ooOoL+Fv+Dcu+aCkWEJY43ZFJdfinwy2dZS2NZ9n+4FWAMioxt7fPn?=
 =?us-ascii?Q?I2n9GfxSAalJAzuDKWEATORMlasEKiGL706W4PogJQJwxPhMBWRGEu2LWSng?=
 =?us-ascii?Q?SIZKsbuSWukOVjOXSKcXc4gO1RCBwhOjfLFKYVVpKfwPKGQv2CBS2dNSDlQb?=
 =?us-ascii?Q?v0ABcHC4Y68P2QVUWyE5iQhFsC7VzbN1GnSFcPuyAvnfgjmMh/FXQru2soeT?=
 =?us-ascii?Q?ItbloDIpoJg/59Sc7Uw6666NaFiwTtkvTvl7bHM/nMndDjSShosENqNtjG//?=
 =?us-ascii?Q?PXGu43mrdnEmtrCpIZdYL8cSiR2c+9HPizC29CS7FmdVGuTNYPQH8fBHr+zc?=
 =?us-ascii?Q?n0s47LikBjNFU4sAGJJluAVdm8i2vGz8KccfpSjGzJ419YyYTTlnXqcgPFuV?=
 =?us-ascii?Q?z1LL2NceNTSaVEZAzoTuMdR9ZNrtghTf/vYa1XfWZGIHzpvDg11ONPzhEvXw?=
 =?us-ascii?Q?6UlaAvFOg9iA2zPwabkYXjhip+EdCinHk9HpC6k4ntB2wA9MPnMUWTRQ19h5?=
 =?us-ascii?Q?m3X+PDyMm+KidCbWPK1TNdmIQ43gkxrxahP64Tr4c8L134e7qR4xI/AlTCoD?=
 =?us-ascii?Q?uh3/a7JBhs1dt8OFQN57Di/uZ1pL5EjCcbKnIYWMm1jGJiArMoytOkjLzfIv?=
 =?us-ascii?Q?Xp4trV+1pu2pVCFPnkjjL10AXllatocZ+jN6xjTQAAYcKcbW767eSZ1Sb0wm?=
 =?us-ascii?Q?1g8WbPqQlWgiYaAmdCejWJl/Pt3ffRPgydGoI10vdYJu4r424BdiwJOARIYJ?=
 =?us-ascii?Q?OfLlQfTXyQrhLEIYKprPybRpHNoNPlf2SjMzqK2CPj6hiulGUnfEzlLmt5NQ?=
 =?us-ascii?Q?gBg4AP1HKp/SoRJ75iGIJiikiJ3J0M9TQuSXgKRIepBPnjb4bogB/bqIcW5a?=
 =?us-ascii?Q?xd+lMQbXtJxw1YCEAjwx06LX+Hdor7YOHyhUay/JgDhb+bdjSGGtlQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nEYG5Bv5UgkuUl960zMVcRtJAFmK+yGb+g5hZWQPe/QlKM6ZiZp12u1PmXLV?=
 =?us-ascii?Q?M6TL4hk3bRzNR4XX5SFawgnX8GYMIeahDUx6ri96uab6mQFpIosAFTFg3HOt?=
 =?us-ascii?Q?61h6ar8y5IasMGO5TYR0vLig6uJqYsrosOkT+H9+c8V9BV4b/RLGqNVIPvtf?=
 =?us-ascii?Q?8s48KK3uqH5N8rsRzI1KEqkOlS6suuB9fKtHRH43zsnhhxP0eCbanxzzuvoB?=
 =?us-ascii?Q?gW7IMWCnDz0WkCDgqL88VfbRWH3NzbyKbvR6ALzV3BLtr54x85PDK854qRln?=
 =?us-ascii?Q?u6nFBYbE3RyxOL/9qWwG4QLIQcakcnLNet2rZGALa9a3zOOXTSTB9SxJEnI9?=
 =?us-ascii?Q?/DPBGgnNswHlnl8utRpUjBxz5cZZLjVn7rkXPpOnZiB0OgmiG/rNur/+Gqf+?=
 =?us-ascii?Q?Rhk6uppGdVAwNel6NxD4jcP8jyE6ANphXJlhrBxVQ3JXI6h0d1uCTcwFuqr+?=
 =?us-ascii?Q?JbSYxQ2iQhlnjWNiB5hyYOfBlk/sODU0KyEj0makd//ASfzwRvnwmOealdcc?=
 =?us-ascii?Q?U8eU0iZeTNijbctAAzIGAMq3x/fb3WTXsZuBigKc/JiMmmASwCSJHJmnEe/o?=
 =?us-ascii?Q?Jl+my3M8IqIIq0h7GwotpdRCGPc8VfhvOn7PKoMMhDitRPlBfMLs2C8VxelC?=
 =?us-ascii?Q?XfzSRLEvYGJj1IuOxlLIVTZwkorlwl7nkVdnDJSYIh9/kIW3UpY4hRnAviLs?=
 =?us-ascii?Q?btZD3+GFI0G3ur+QQbxbZnxT2o4B+gKr0fQIGelkn+o2wh0FrdGhZpa2qIJk?=
 =?us-ascii?Q?a1LbvtKmn8vBYy5zrn8oD2xthQphPY9WH9l304UfCFPhHAA6DmmDjloemp9j?=
 =?us-ascii?Q?pJyijAZ0UaKjm+oShpO5R29JRgf3FDQJ8X5D24WYX0NdLTYLk2EnJ8Rtv9h9?=
 =?us-ascii?Q?KI9bNcet53wCwhdd/ciqhVGpbnHDWRTURJDokeAp1cOF7jkcAor0IY1mvJXC?=
 =?us-ascii?Q?KyfTzTQua1L/s/bRhlHq3yMqqPeYeHHY9rTQfq+BuiWWTW5XdFeiboCaowV4?=
 =?us-ascii?Q?AzVzGO+GuoEX3+y4vfjajyeQnup+P73JZy52hcqm2P+VWCPwCu2FKX1kIkFF?=
 =?us-ascii?Q?VdKz8YkBPD7DdWmH7AwzIYXHLPsQhdu6Edh2ewJo5DmYTrgMZsWHuh8XK6Lt?=
 =?us-ascii?Q?MLhN7AyDd/8gIEdco+Zs0VxKR5tfdzxnH0zjR7bDWoQ1aGLSi6jLnMtZL4Mg?=
 =?us-ascii?Q?AicZ9Dg0qLOXSHK6mnTJ8ytM/gYnvLgshbfBvOZ2CDjOJZM3rPLesXABOH3T?=
 =?us-ascii?Q?2u9cGJejVAAm/0IyEFQZu4jAxBvg4wdW1EiTAdNphEMbI9qpze+4nsYVBJxl?=
 =?us-ascii?Q?FiLLZhNAIlQfN77N6P3k1IDgq3WMvrIEHgVooEMLmIwZ8kpHHoYXvalaeces?=
 =?us-ascii?Q?EUOe67UPIxNbvC+cYHlPmFFZTxo3wO7iRw1+OiZgnqkrgNxrkutHcklvBZCj?=
 =?us-ascii?Q?dsEnP9i7YmZmSs/sRcRJWit3JWIaaGkA53+UgB1R8kB1uj1xn5Qc19MQsum6?=
 =?us-ascii?Q?3FIw50ybz1ZAPpQEc0RbON5LbV6pK1HvC7VhMd2PP9kscrLOchH05dBrsQHz?=
 =?us-ascii?Q?RuGV523Z0th/XUAmVWvuyKTDJQYaI3l55D5S6xag?=
Content-Type: multipart/alternative;
 boundary="_000_055a2062699c4f4c822c17fed6c982c5amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4590bcc8-8218-401d-5895-08dd8e178b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 10:03:13.2915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbT/OAhpPVtrC4/7+B9axQa5BC3fVVyh77JZyCI1RHpz3HvpwN1DveBPwfj+ZSynEymYoi9GVENpaygbqmO3Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386
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

--_000_055a2062699c4f4c822c17fed6c982c5amdcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


On 2025/5/8 16:12, Lazar, Lijo wrote:
> On 5/8/2025 10:39 AM, Samuel Zhang wrote:
>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>> is enabled, XGMI physical node ids may change when waking up from
>> hiberation with different vGPU devices. So update XGMI info on resume.
>>
>> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
>> Signed-off-by: Samuel Zhang<guoqing.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  4 ++++
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 ++++++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
>> index d477a901af84..843a3b0a9a07 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>               r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
>>               if (r)
>>                       return r;
>> +            adev->gmc.xgmi.prev_physical_node_id =3D adev->gmc.xgmi.phy=
sical_node_id;
>>       }
>>
>>       /* enable PCIE atomic ops */
>> @@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool notify_clients)
>>       return 0;
>>   }
>>
>> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
>> +{
>> +    int r;
>> +
>> +    /* Get xgmi info again for sriov to detect device changes */
>> +    if (amdgpu_sriov_vf(adev) &&
>> +        !(adev->flags & AMD_IS_APU) &&
>> +        adev->gmc.xgmi.supported &&
>> +        !adev->gmc.xgmi.connected_to_cpu) {
>> +            adev->gmc.xgmi.prev_physical_node_id =3D adev->gmc.xgmi.phy=
sical_node_id;
>> +            r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
>> +            if (r)
>> +                    return r;
>> +
>> +            dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>> +                    adev->gmc.xgmi.prev_physical_node_id, adev->gmc.xgm=
i.physical_node_id);
>> +    }
>> +    return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_device_resume - initiate device resume
>>    *
>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, b=
ool notify_clients)
>>               r =3D amdgpu_virt_request_full_gpu(adev, true);
>>               if (r)
>>                       return r;
>> +            r =3D amdgpu_device_update_xgmi_info(adev);
>> +            if (r)
>> +                    return r;
>>       }
>>
>>       if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xgmi.h
>> index 32dabba4062f..1387901576f1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> @@ -89,6 +89,7 @@ struct amdgpu_xgmi {
>>       u64 node_segment_size;
>>       /* physical node (0-3) */
>>       unsigned physical_node_id;
>> +    unsigned prev_physical_node_id;
>>       /* number of nodes (0-4) */
>>       unsigned num_physical_nodes;
>>       /* gpu list in the same hive */
>> @@ -101,6 +102,9 @@ struct amdgpu_xgmi {
>>       uint8_t max_width;
>>   };
>>
>> +#define amdgpu_xmgi_is_node_changed(adev) \
> Typo - xgmi
>
>> +    (adev->gmc.xgmi.prev_physical_node_id !=3D adev->gmc.xgmi.physical_=
node_id)
> Since prev_physical_node_id is updated only for VF, the check should be
> there here as well.
>
> Otherwise, you may have something like below in
> amdgpu_device_update_xgmi_info()
>
> amdgpu_xgmi.node_changed =3D false;
> if (check_condition) {
>        prev_node =3D adev->gmc.xgmi.physical_node_id;
>        adev->gfxhub.funcs->get_xgmi_info(adev)
>        amdgpu_xgmi.node_changed =3D (prev_node !=3D adev->gmc.xgmi.physic=
al_node_id);
> }
>
> To make it clearer -
>
> Would still prefer to wrap under amdgpu_virt_migration_xyz() to make it
> clear that this is done for node migration.
>
> Ex:
>
> bool amdgpu_virt_migration_detected()
> {
>        return amdgpu_xgmi.node_changed; // And any other combination chec=
ks
> which could up in future.
> }
>
> The check needs to be done for any further changes down the series like
>
> if (amdgpu_virt_migration_detected())
>        psp_update_gpu_addresses();


psp_update_gpu_addresses() and other gpu address updating logic will
always needed when pdb0 is enabled, not just when detecting xgmi node
changed. Because when pdb0 is enabled, the returned gpu addr from
amdgpu_bo_create_reserved() will be in GART aperture, which is not
compatible with PSP and SMU. They need to updated to FB aperture addr
using the new `amdgpu_bo_fb_aper_addr()`.

That's reason of the last 4 refactoring patches, to remove the cached
gpu address completely and convert to local variables.

Regards
Sam


> Thanks,
> Lijo
>
>> +
>>   struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *ad=
ev);
>>   void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
>>   int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct =
amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v9_0.c
>> index 59385da80185..7c0ca2721eb3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block=
 *ip_block)
>>       struct amdgpu_device *adev =3D ip_block->adev;
>>       int r;
>>
>> +    if (amdgpu_xmgi_is_node_changed(adev)) {
>> +            adev->vm_manager.vram_base_offset =3D adev->gfxhub.funcs->g=
et_mc_fb_offset(adev);
>> +            adev->vm_manager.vram_base_offset +=3D
>> +                    adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.no=
de_segment_size;
>> +    }
>> +
>>       /* If a reset is done for NPS mode switch, read the memory range
>>        * information again.
>>        */

--_000_055a2062699c4f4c822c17fed6c982c5amdcom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <E8EA38568EB6064A8BCB98BBCE6B60BF@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><br>
On 2025/5/8 16:12, Lazar, Lijo wrote:<br>
&gt; On 5/8/2025 10:39 AM, Samuel Zhang wrote:<br>
&gt;&gt; For virtual machine with vGPUs in SRIOV single device mode and XGM=
I<br>
&gt;&gt; is enabled, XGMI physical node ids may change when waking up from<=
br>
&gt;&gt; hiberation with different vGPU devices. So update XGMI info on res=
ume.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Jiang Liu&lt;gerry@linux.alibaba.com&gt;<br>
&gt;&gt; Signed-off-by: Samuel Zhang&lt;guoqing.zhang@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++=
++++++++++++++++<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp; |=
&nbsp; 4 ++++<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 6 ++++++<br>
&gt;&gt;&nbsp;&nbsp; 3 files changed, 34 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; index d477a901af84..843a3b0a9a07 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; @@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_device =
*adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;=
<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gmc.xgmi.prev_physical_node_id =3D adev-&gt;gmc.xgmi.physical_no=
de_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable PCIE atomic ops */<b=
r>
&gt;&gt; @@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_device=
 *dev, bool notify_clients)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *a=
dev)<br>
&gt;&gt; +{<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; /* Get xgmi info again for sriov to detect dev=
ice changes */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;flags &amp;=
 AMD_IS_APU) &amp;&amp;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supp=
orted &amp;&amp;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gmc.xgmi.con=
nected_to_cpu) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gmc.xgmi.prev_physical_node_id =3D adev-&gt;gmc.xgmi.physical_no=
de_id;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (r)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; dev_info(adev-&gt;dev, &quot;xgmi node, old id %d, new id %d\n&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.prev_ph=
ysical_node_id, adev-&gt;gmc.xgmi.physical_node_id);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * amdgpu_device_resume - initiate device resume<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt; @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *=
dev, bool notify_clients)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;=
<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; r =3D amdgpu_device_update_xgmi_info(adev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (r)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;switch_power_state=
 =3D=3D DRM_SWITCH_POWER_OFF)<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt;&gt; index 32dabba4062f..1387901576f1 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt;&gt; @@ -89,6 +89,7 @@ struct amdgpu_xgmi {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 node_segment_size;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* physical node (0-3) */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned physical_node_id;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; unsigned prev_physical_node_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of nodes (0-4) */<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned num_physical_nodes;<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gpu list in the same hive *=
/<br>
&gt;&gt; @@ -101,6 +102,9 @@ struct amdgpu_xgmi {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t max_width;<br>
&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +#define amdgpu_xmgi_is_node_changed(adev) \<br>
&gt; Typo - xgmi<br>
&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; (adev-&gt;gmc.xgmi.prev_physical_node_id !=3D =
adev-&gt;gmc.xgmi.physical_node_id)<br>
&gt; Since prev_physical_node_id is updated only for VF, the check should b=
e<br>
&gt; there here as well.<br>
&gt;<br>
&gt; Otherwise, you may have something like below in<br>
&gt; amdgpu_device_update_xgmi_info()<br>
&gt;<br>
&gt; amdgpu_xgmi.node_changed =3D false;<br>
&gt; if (check_condition) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev_node =3D adev-&gt;gmc.x=
gmi.physical_node_id;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfxhub.funcs-&gt;ge=
t_xgmi_info(adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi.node_changed =3D=
 (prev_node !=3D adev-&gt;gmc.xgmi.physical_node_id);<br>
&gt; }<br>
&gt;<br>
&gt; To make it clearer -<br>
&gt;<br>
&gt; Would still prefer to wrap under amdgpu_virt_migration_xyz() to make i=
t<br>
&gt; clear that this is done for node migration.<br>
&gt;<br>
&gt; Ex:<br>
&gt;<br>
&gt; bool amdgpu_virt_migration_detected()<br>
&gt; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_xgmi.node_chan=
ged; // And any other combination checks<br>
&gt; which could up in future.<br>
&gt; }<br>
&gt;<br>
&gt; The check needs to be done for any further changes down the series lik=
e<br>
&gt;<br>
&gt; if (amdgpu_virt_migration_detected())<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_update_gpu_addresses();<=
br>
<br>
<br>
psp_update_gpu_addresses() and other gpu address updating logic will <br>
always needed when pdb0 is enabled, not just when detecting xgmi node <br>
changed. Because when pdb0 is enabled, the returned gpu addr from <br>
amdgpu_bo_create_reserved() will be in GART aperture, which is not <br>
compatible with PSP and SMU. They need to updated to FB aperture addr <br>
using the new `amdgpu_bo_fb_aper_addr()`.<br>
<br>
That's reason of the last 4 refactoring patches, to remove the cached <br>
gpu address completely and convert to local variables.<br>
<br>
Regards<br>
Sam<br>
<br>
<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp; struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct a=
mdgpu_device *adev);<br>
&gt;&gt;&nbsp;&nbsp; void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hiv=
e);<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_xgmi_update_topology(struct amdgpu_hive_inf=
o *hive, struct amdgpu_device *adev);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; index 59385da80185..7c0ca2721eb3 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; @@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip=
_block *ip_block)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D=
 ip_block-&gt;adev;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_xmgi_is_node_changed(adev)) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;vm_manager.vram_base_offset =3D adev-&gt;gfxhub.funcs-&gt;get_mc=
_fb_offset(adev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;vm_manager.vram_base_offset +=3D<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physica=
l_node_id * adev-&gt;gmc.xgmi.node_segment_size;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If a reset is done for NPS =
mode switch, read the memory range<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * information again.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_055a2062699c4f4c822c17fed6c982c5amdcom_--
