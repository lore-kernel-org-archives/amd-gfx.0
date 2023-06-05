Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859CFC77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 19:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F7F10E1E2;
	Mon,  5 Jun 2023 19:45:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0735810E1E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 19:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9IrcTiplFbLg5jdG3MiLtE7A9CO16zwXudHL1ux3Ps4laMsMvxNsTyXluok3VOpDdoCQaxxZzKkf8Aa8hh9x+fqUnjAnp6DogqewOmaigmsuwbezhqiIy+JUmTiIWrlZaM2/HBtgD2oP3q0RizIfU/LX7NKhZ1MRZPNEqVghIIA6TuYsa5X9I2Lg0+TEmLfGyLQky22skt2QwdiDl4QoGk88lkMIHxbIk1sDahU416AHcQ0W9US9BQTPDBCvsu7bywhGYAZgqp0kn0Tds4Gr0irh7G1KcNyU2B05E/ef/JUgoFK5xM2fxdlh8zMiW5JOO86ogdxs2aOEQ25ynembQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdcSmqh9K9fa+69KN5sd+nJgks/Lqqa0+FXpUkYB0XI=;
 b=hK07c6ohpK3ku8cKvXKI9w2aOyRxHRnEZEFc4GPReCM5UV5B0qheXEqfDEjs/l0hREBRgSuYmkZHYC/PEdZKxwYvrYPBA+jOzXnZfP+U1RQXzOal3q1t0GBX0LrgLptPXvsSMPj8buQPwmBwImo1niOOQLAe3x8jO3yY2AvRVQIKz9EEs7dPIzUboCDqk7irBx7fucX58LbK8jOwPCra6dou/URKAtnEkzHP6jLb+X8OMawxViQ3A8C/1VQetpAVWW5jpl+sAGEF/VeoxQRHmcl0o5XAI2Wvne62zkKxDf4FcdRAQH+GNjLyXHr8oStoOyoI7ny9Xkg3VS/AkTk4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdcSmqh9K9fa+69KN5sd+nJgks/Lqqa0+FXpUkYB0XI=;
 b=U9pe5uZFrREzqWOIgkpRMjnl/FHAmM0duHdkhHExtM3cTwIEU+F5knLfEMgYGSrwQf2p5MsRFevIh+NcmFMfL8JoJ/IwYzyL6tyn0CbpmxD+kEHFd6T6NVp8G7DOb8MIuJPa/VroTGBeQ2E4Sd99QDBAdTY60WRzQAg9c5YtjzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 19:45:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 19:45:42 +0000
Message-ID: <2395f465-fd8b-8b9a-5ea3-82157ddd4fa9@amd.com>
Date: Mon, 5 Jun 2023 15:45:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd: Check that a system is a NUMA system before
 looking for SRAT
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230602121806.25441-1-mario.limonciello@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230602121806.25441-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CO6PR12MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: f11ca7b3-7848-49b8-cefc-08db65fd7229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27msb8QEEGOZ4rIEYXxAQdLDwVXGq3vEGf3FW571DsA+1vOTBHEPQRz/B1vA7KU7YpAoT28BSWmWVhk3Zjn4a4x+TdbLjLysHoWjec2Sus8zlepPVhqQXuX1O8U9B3g17GWop/xXmSjTGPls4JDhbhAoIJrr8F7q2g8jFtTM1fHoWPtCzXfiQI2N2l3yjQs9MnVblWNqrq7HyHX2IFiYjMSqZ4AYsQYetcpsenRgFxRSY1tUdz9EzYmZY3dB++U7fQ3/Nn5erLTO6dJ/WCB6AA/MO6N5/Qx+NRta4baopHlTkY5KsWaHIGKp5MJMZmua8kftSCErFEr9nVj0qB/Vm/PGguHa7BS0Flt8TKGjl7WuIx+o7pl+oRLnHS962gZ8OJKuuBkqFhwjiq05qx7v3fuZw8Bey3Y8ikky5W2d5t50TnZ9Stf9Wr+76Eul5NFahuPgSqBoFDGjl3C8qAc1vnoGLB+jRiYHf9cuJM998fdcwMxIs/BGtinzgslypC7LNC+Il3lfgo2zplJkkTRE5FwtzwmgmGb6FeK6bo5SwVsCPK2Eq74Ft3B3HL2notI5scNQ1JXYpAUUD5H7rY9Xe5KuNUkBQw9hue4OY5vRfr9D1pADmicwMoz9wc8C5rFEvjBaYFdTqBTpNa+G9z+9dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(8676002)(66556008)(66476007)(8936002)(66946007)(5660300002)(316002)(31686004)(41300700001)(44832011)(2906002)(478600001)(38100700002)(53546011)(6512007)(6506007)(26005)(31696002)(86362001)(186003)(36756003)(6486002)(36916002)(2616005)(83380400001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hpYk5CK0lSTU41QmdrS3hwY2JBVGxwUGhFTkI2dW5ieGpZUWRYMmV5Q0l6?=
 =?utf-8?B?VFk1NHVLbGZJajdON2RnY0NOLy9zcVU3U093YVVLYTBaQ2Vuc1pXYXR3eGJp?=
 =?utf-8?B?SVZZWEhDL3B0dTl5U1A2MkxFakx3SmJoVm5KM2QwMDAvT1NrRVRtQWp1NmJs?=
 =?utf-8?B?T3VWMGNZOExFQkpKZmZmNFNLSkljVHg0YVdxTm9sWkhxUEh5bXhrNElEUkNl?=
 =?utf-8?B?RTN5K05jeEhLUmZMenhnb2RyR3p0L1k0emx2RWp0bGlndkNJcy80N1VXamJa?=
 =?utf-8?B?WEVsb1JST0VodEhWdGZ5bjhLRmk1dEVROU4zNzJiUEdXb2lBbjM5NFN0NllN?=
 =?utf-8?B?enptWHZVV1BBemhORmxoa3FXSUVIRU9UT1F6Y2Y2eFYxRTN3WCttalJqVEdC?=
 =?utf-8?B?bWF1ZWQxUGhYdHZ6YmJzajhRMkdjV3pab1BTS2pzYm1PUGh2NUx5VzhESzJ4?=
 =?utf-8?B?dy9ZMHdOZkY3SDZsM2NyVXAycEJOUmdkZndhcWpFc1h4NU5yTjhlRVNZeE44?=
 =?utf-8?B?aXcvTmdSWHYxNWRRdzNjdDlvcDEyTHEvSE4vSXE5QnBGcEdWM3M5dWNTVFVB?=
 =?utf-8?B?SmZlbkVMYWUzR1ZXeVhKRmlYZ09BNWNSVTlXZjNiSXdLMWdobXlYS2I1NGxD?=
 =?utf-8?B?ZFJmakNkUjBQQ2l6dkloc0pNb2pyZEx3cGtJc0ZGbXFOUnZxdHd2OWRyMkti?=
 =?utf-8?B?dWlOcFNZb2h6Q1lTaG42U3RxNFdZaU5iNzd4WGlrcDdmWlNTMTJTTllIajhI?=
 =?utf-8?B?c1RkQ1pRaGY3NjBMMmhyUmZGOXU1VDhpQVliZFNGU3BpaWsydVYzMmllVE80?=
 =?utf-8?B?QTVDMEpEVU1TbWp0VEJXbllqc3V3U3gwUVk3ODNielMzTWZEcXZ5S3F2V2M0?=
 =?utf-8?B?Nit2TVh3Z3ZKenRZZXZ4V3NwS3ZYTWI3dmhHaGJjb3hxSUY4NCtYcDJxMzRX?=
 =?utf-8?B?TTZMSGRlQ0JnaExjQ2ZHV0ZraHFlc1ljWFVnN1ZVeXlXN3JORFNuQ3JHZlAw?=
 =?utf-8?B?Y1c3eXMyMFRkY0tTRkdYcDdudjJhUi90ZEU3ZDVOY3FTZVhBVHhjSlNhejNT?=
 =?utf-8?B?T3dHZDM1NUNqaFRZZTRpbUdGdU5xcHA1L0p3dm5VeFJkMVFKWEZDT2p2RTVx?=
 =?utf-8?B?cGZiNjNmem5LcStuM2ZpMGduSEREcFgrTVFyYmlwdVE4R2hhVU4zK0tTRjg5?=
 =?utf-8?B?NldEanUrTWJkWm1yYUtkT2RjbDFjZWpMeFdNSkR6NEZPdjNMYm1xSzhOeERF?=
 =?utf-8?B?VTBsblk5SjlnQ3FCcTJ5TFJWVXhoellLUkNWZCtJZW1xRDRCUldYU3h0emtN?=
 =?utf-8?B?eXBnSEoyNDI0U2U2QXNJeExNUDVDeVBGOHh1NXpSaHZ2cGZwSzdPSy9DalVs?=
 =?utf-8?B?VHNqRjN6WWxIK2E5T0hpQmVzYnF1Q3cyVTlTVmJmQVJlSzRwZGVweDE5Z0hy?=
 =?utf-8?B?ZVpPYUJwaFpaVjIxdE9WT1ZRWUpYZTNUZTV2TWxFeWFFYUQzajV0STgvdzNv?=
 =?utf-8?B?RnpWaExpemJuYW9ocmdPS0N3cFJOdHJEdjdKckV6WWtWK0J3RE1qN0NWZ1lN?=
 =?utf-8?B?c1F5TndUcUc4NmNMa1F2L3p6d0ZmME0vMVRwRHM0SEtxYTlVbC9xeCtoTk80?=
 =?utf-8?B?akFpUC90K2xnQ2hRb2ljeDV5ZmpMaHA3YVJDc2ZCZGFCUU1yY3gvRU05aC9G?=
 =?utf-8?B?cUQ4UXZWQ0xxU1dVMjZjTXJIK2xDaWdJNE9TMUJ0YzQyNTZHaW5ta1FGRDR1?=
 =?utf-8?B?cXZ3YmVxTWJaQU5oYk9ZYzdNc2c4ZXRmTnFSeWVQRzY1UUN4dmJFbVdQSnVJ?=
 =?utf-8?B?TG9NbjRxdWFDMGZsV21DM0QxU3IwSjd1NXJsNWxoYXhXcjJWMXNiNXl0Nkg4?=
 =?utf-8?B?MjF3RWpsSG5Qd0Z2czRBaGhkdi9jbVhSUkpOczhpcTRJY2Npcnlsa3ZUa0ZZ?=
 =?utf-8?B?NlhEYnNRRi85U0dUaFBOQkZpeXc5ZXhucE5lUzRWUHdaSGtjWFcrYzhrdEQy?=
 =?utf-8?B?cklwQ1FrRmRkUlhxQi9TNkI0enZpVGRIZ0xRNWFnWXVJTFk2Umc2VEFuYmRk?=
 =?utf-8?B?aEl0R0djM1c0eHhBTWp4R3BMRHF5TU53YXpoOHl1RWtXZHZ2OFFhOGRldGxm?=
 =?utf-8?Q?oa6MXUPzZhYXEoPr4vDmWGfP8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11ca7b3-7848-49b8-cefc-08db65fd7229
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 19:45:42.1448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqSsBn4DbNMLiS97VddFD7r0BQUaElEShIcpZa4zUhi8E/m1SXY22NMWW6oqEYm2vRcExhIb3HaoMnLcK/iofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
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

On 2023-06-02 08:18, Mario Limonciello wrote:
> It's pointless on laptops to look for the SRAT table as these are not
> NUMA.  Check the number of possible nodes is > 1 to decide whether to
> look for SRAT.
>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I think we discussed this a while ago and I don't remember the exact 
issue that was meant to fix. Was just to get rid of an irritating 
warning in the kernel log? Anyway, the patch looks good to me.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 950af6820153..3dcd8f8bc98e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2041,7 +2041,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>   	sub_type_hdr->proximity_domain_from = proximity_domain;
>   
>   #ifdef CONFIG_ACPI_NUMA
> -	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE)
> +	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE &&
> +	    num_possible_nodes() > 1)
>   		kfd_find_numa_node_in_srat(kdev);
>   #endif
>   #ifdef CONFIG_NUMA
