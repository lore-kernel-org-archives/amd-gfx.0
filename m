Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A255BC46CA2
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E61E10E2B2;
	Mon, 18 Dec 2023 18:23:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0B010E072
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:21:48 +0000 (UTC)
Received: from DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) by
 BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 16:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l92/8++I1yqqw59We0Tq9P3e9Gm465ed5uD2xykF0ozFSpXdhu18OpeTf6B5+Knt+RI4adu7aFz4EGH0LE0S9uny5oQwWicwL2oz9C49jxFB7y33gFmdsrCBF3lQcp6VUCzLEq88Kgm7Ob1DQQz6qi3so2eD23J1+s4Wjq8kbcxX1yd8W7+uIeS7qJGHpyfZcm60XpyAVgIZFSwYrUEfzP3s7RgQqExD+oGXjbxAfVStywVDvkeZuT/5uz6Sr90oSInBVNLVyZVqpsKTOUhtLjPpGspR4f+3MsEw8oCrP6d6hiTw9GZxaSx1o2Ovi8vLjEUv+oBx4mldBwlLm4N5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQqh+gRDwFueNMju5m9KZIBjOoGD5jFWRHBkxwjN6x0=;
 b=HC6o+POiX6D9cBjSukqYdkjiCbX2tMqc2h4jFK7QZCgwdgLT47slJ+KilHUZn7OcxdEDfMjEm3TpEgtPme0DlXRKtMJvtiQJNshd8izt6sozy5EiIy+ZoQiqqQH6pXATaOsXm5no8AHe13jWMqAWxnYGM1YhtBXgg0LEKtbMKsyaqxA74B19sUmwTAw+E5bhJoIBWkxLjWjPrH0AJoXMaQgAZYchkOWa5JegRmmWiMKslGhSbGGJDt0tY45QLfLYryClFsV/CEqO73cW7jLcSr//oUw6deopcxbSo6wrEwFCdeVKxfMZFy6DWU0dk/8jGq0FHTpvMRI/FCGDnUdEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQqh+gRDwFueNMju5m9KZIBjOoGD5jFWRHBkxwjN6x0=;
 b=QUR5zwDa3FS2N9o69PEoYhHfADGuI2tRp0kjqCCdDfmC+rTokSuPG57A7IJLbWkv9AoV1OJicBRyqO4zcTY7YpuflrCg21NRyIBm0kOyEtKowYV0eBbHjjHwzmcJL6zS6rMlN60Y93ZNE4SXiTYUw6JvbrB4/ZB5AcVaZbwibZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 05:21:23 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 05:21:22 +0000
Message-ID: <60de2627-19e8-403d-a148-fd34647f9e99@amd.com>
Date: Mon, 18 Dec 2023 10:51:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amd: Retry delayed work handler if sensor is
 busy
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231215195536.20401-1-mario.limonciello@amd.com>
 <20231215195536.20401-3-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231215195536.20401-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB6664:EE_|BL1PR12MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: f4805e46-4487-4d83-e7cb-08dbff892bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C71ohsWCQz1DCcyG02sCbUEBrSPeGMuFvg0gG+LySQHZIsSYccP23pA/01DVXrOH5DdVlmokI8JUpga3xMV6KgxIYbuRgVMzsJiLTtTmXFUF8zwzIUiybsZEytWVOfIrpXm2g5Fj2jRMra8sDt2dDJYArhSGP8WLIn9dc6OMWpa8v5BgZKy6PMjDh7n3p7WYi3V9N6NS1uGG7T4bCf/2AUTnyOfzh3mrjzCwn9qytfQLaGYYFzANHIS2am/qAWxiZU6zGVZ6n7X2p7kpI7ON0uExfxq5DWeMv+yPhOo7pVlLDYs5rqtj+slu0NWb652QlANdvoSEN3Lc9A87YTOtsIlIot9zmLj0HPzFEwSo5I9Es2M0b0IkRUe/G+1DsAkrP0dE9xAsKX9mx6grn2eXWriO3O01a2BNSi+YoS7OGqj6IoF7U5v6t/sHiHRgA1jVQ02FxofxyVlXhZqnmzpnrS8n6P8k9HGt4EN9V7FcggdxN5Bhd43N+2AcwQapLGGipE0WxBTDEIPAbOzKA7EKvFN5W+ZFhuuLD//BR+z1nEJYPPt4w9HJVroG6LHKb57WrWc+tnqkEKhGdPp6M2JC2hn76Ox7kqnDH8uxLjv+LRrJrxxmYhFj2O57yq6XSKj8wo6CCN/EkWsyU+a80JdRBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(38100700002)(36756003)(41300700001)(86362001)(31696002)(66476007)(66946007)(66556008)(316002)(83380400001)(6666004)(6512007)(2616005)(45080400002)(6486002)(478600001)(31686004)(26005)(6506007)(5660300002)(53546011)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlpMDM2TVVlNUMxcHRXVTE1aEpwWnNReE42RVhuVkl1em5qN2c3bXd5dkZz?=
 =?utf-8?B?VDNzOGxzUGJoU0R0aHM2bjRlMzQwT0I2M3BXWDFtRDZVRnM5bEZMUWlmcmRK?=
 =?utf-8?B?bWFoMzdETUNQOWFEMkMxOTlpRURVR0JqdTVYelBIQWlEZXBRNkpwNVhUZjJS?=
 =?utf-8?B?RTd1S0U0M2lnTFdPWVdBaGRjOHRpaldaL2hLSlNkSnNtb2ZUT1M5ckdsN0dl?=
 =?utf-8?B?WWJuaDA1cXc1Q0FwUnFHU1h6Tnd1VVVRNitVZFdoc2k0cU0zaUY2RGF5Mll6?=
 =?utf-8?B?TkNvdjFSNUdzdWU3aGdEQnVyYU9jaVd1QTF3VmQxdi9hUUE5QlRFYWVPNDBk?=
 =?utf-8?B?akx3OXN5SWIxbS85Y2RmTzEyYnBrZ2NnNi9CbXljeDJJOHZTSmt1UDJ0djQ3?=
 =?utf-8?B?VFppSUlXbmF3czFKTjhSUlo3S0diV3QvOGs1OFdCSHd5MVowQWY5eWlVd3pX?=
 =?utf-8?B?bnN6UU5yRlRsaGYvNjNxYXRjKzNzMG9WckppVyt6K0V1ZTNoWHJyZE0rcTlF?=
 =?utf-8?B?L0U3Uk9tM1E5WnBHTCt5WEF1Vk5ncEFKMjRwb1NlYlFleFJ4RjBQRHJmZDU0?=
 =?utf-8?B?T1IweGMrK3NDTy9jQndOVDZEclZrRE9RQjFNL2J6Sm9jL1gvREtPNnJ5a2lF?=
 =?utf-8?B?QTIyUExVek5aYWNvOFpEMzQ3cmduSzhYVm91em9rR0d1Q0ZGVmROVjVPWkFN?=
 =?utf-8?B?VVNXZlU0ei9mN1kvL1R0SFpuTXgyZDhXc00vc0FXOEIxNDZvSzRIL095MGNB?=
 =?utf-8?B?SVJCSEliaFFqOTBJdm9VYnArU21kUm1zZXMwOFluT3FIaTg1Sm0wanZjQlo4?=
 =?utf-8?B?ckZzYVowbVFBWS92bVk1QlllM0ZyZFc1ZVgxZnUwTDlHaWplUk5GeDF6N0hN?=
 =?utf-8?B?QUpyT0V0K3BIQkxGaldoeGJqNFp6eFZsSFRRRXplOUJHZStta2krc1h2Rm5x?=
 =?utf-8?B?c3JuSUZ2TzNGRVhSaVhHU1dJdjUvQ05Nc2Z0WkVKN0NiNmladk82aDg3cDFm?=
 =?utf-8?B?Tkh2RzhWZE5DbFpnakZSTWN3ZEd0VmRYTnZyMlhQbTUyWmhjWVRXZDlTbGJh?=
 =?utf-8?B?d0EvUXlhaGs5ZkpjTmdkdVB4M2V2MkZBRWpJSEVLVURuSC93WXYzYWRKUVlH?=
 =?utf-8?B?MHdqQ2JXZWFjNFdPbDc0TUdnWi9xSHh4VWE0N2FLV3V2NlJVYW1HREFSdXFz?=
 =?utf-8?B?M3pwUHpZKzV3VFV1TEhjODAyTVBHeVVFbC8vRVJpS0xOZUs2cHAwUzFEUlpn?=
 =?utf-8?B?MnhDVDZGOGJuQVBGZjdvY2FvWTM5aXcycFc4cnppU2gxTWY3eUgxQXFxeEhU?=
 =?utf-8?B?RitZRVJnYzVzcU8vczBCWUZnWUp6cG9LSjJCNXg2b3NCY3ZLS2laNlgrQXdC?=
 =?utf-8?B?ZGZtdFFPMGhPN2hkbGE2SlhxUUU3b1d1bG1FVVR3bksyV2c1Y05JNC96STN1?=
 =?utf-8?B?ZTQxYmE5U0JqWjU2SUNUZk5tRUx4THhlUG03L3RWNWROYnJ4bXhHL2RhSXZv?=
 =?utf-8?B?Z25oTC9Bd0JLODRJUCtvL0d0VG5ZQUp4R1ZtajVKS3A4RTFaUG9OMDloWTNw?=
 =?utf-8?B?UGkyV2k4dUVLZVNDL1RUNWgxRjVGV2gzNmRZakpzdG5LWDRPQWFhVkVkTWtQ?=
 =?utf-8?B?azU0QjNabTJxU2o4Mms2aitLRXF5RS94cElSZHVDUm9meHBjY2RiMmUrUXJi?=
 =?utf-8?B?NTdLWHlyMWdmR0xHd2xIa2V4OG0xcDc0dHp6SjQvWHFWMExHRjIyQk5Va1Vw?=
 =?utf-8?B?cTVVZi8rYUw0TUJrT1djTDEzVGE2TUUzdmg4MHdETnNCUHJrU1MxTXdzN1B3?=
 =?utf-8?B?eHJCRXQ3TlgyS0lwOTNoMmlzUnd6MXk4aVZjeUFmdll2UStZQUY5TzBTelRp?=
 =?utf-8?B?Zlo4WHQ5Q0RkUHhFWkRuYVJXLzhGZGNCaXl6dzZCUUN6RXJ5K2UweUwySVU3?=
 =?utf-8?B?MzN0bU1odjdrSEZSWm52QXhzdFhlZHJHMWdkenpJN2ljS0V1ZnVXbEVtS0VM?=
 =?utf-8?B?ZGFSZURZaFRXZVJMREZqSWh5SmdUTVNVVzVzOHBURXQ4VTBRMit0eCtLV2FE?=
 =?utf-8?B?ZDkwRitoVHAzcEkzOWFVTVNWMTRGMXdRcXlPVEFhOU5HSTdrOUsxOGpUZ3E2?=
 =?utf-8?Q?9Iq6rAOhgWeAx3Pd1qiluXXZk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4805e46-4487-4d83-e7cb-08dbff892bd6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 05:21:21.9567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiUKkciVpZbGMTKDG84M//YosF3crMcjikuSWyJSHLHTTWqQ1c4PRBoxvSawo6wg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
X-OriginatorOrg: amd.com
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

On 12/16/2023 1:25 AM, Mario Limonciello wrote:
> The SW CTF delayed work handler triggers a shutdown if a sensor
> read failed for any reason.
> 
> The specific circumstance of a busy sensor should be retried
> however to ensure that a good value can be returned.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 963cf6e76935..5eb46b6bad43 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1182,6 +1182,12 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
>   			if (hotspot_tmp / 1000 < range->software_shutdown_temp)
>   				return;
>   			break;
> +		case -EBUSY:

In patch 1, presently -EBUSY is returned for
	1) RAS interrupt - A RAS interrupt will eventually result in a reset of 
the device. All processes running on the device are going to be 
suspended before that, so a reschedule here won't be necessary.
	2) Only for arcturus, aldebaran and smu v13.0.6 - Aldebaran and SMU 
v13.0.6 don't use SW CTF (SW CTF limit is set in aldebaran in such a way 
that it won't be hit). I don't know about SW CTF usage in arcturus.

Thanks,
Lijo

> +			dev_warn(adev->dev, "Unable to read hotspot sensor, retrying in %d ms\n",
> +				 AMDGPU_SWCTF_EXTRA_DELAY);
> +			schedule_delayed_work(&smu->swctf_delayed_work,
> +					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
> +			return;
>   		default:
>   			dev_err(adev->dev, "Failed to read hotspot temperature: %d\n", r);
>   		}

