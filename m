Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19552C25B08
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 15:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7539712D;
	Wed, 17 Aug 2022 15:04:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8D697257
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 15:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdOft58v3aoXucjYcv4Xs0pYAz+phFoJd5qbF6mAw0XxMIEh0/5EewIcND3A2AwSB9TEUgW+gkEwNAZwxrTMo4BE7uTqaSPAf3YlXR56uEhO2Y1Y8mgMXIda7hFDdL2O6aaPXw+T1E1xKZgaFSjjumi1Kz1RF1YQeJPMagVN0nv70wKPHD8wSBXjOhGlSxoI19kWXjPOlfo7Io5CKGkaj6KtWsCd09Oe9Xh89oAQ4zwvrsnOi3TF2nGDX2zNsyNNH96uBGAyC7cjOrzO5HyBZTcHpuuaX3OlWsYQRlhstHE+BaTPYrolUIlpr2EZpVVb0sHr9snyJ1/QrLRkJRsqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anujQiqtOQvvKEhgxTXQRKH6UyRigaoj2hS4DvD0AXQ=;
 b=abmP/ioS/NfJAp0y5zTyKkKj1YE8i2ZeH6oz0xXzT2kcAUAuFq0RD1dFXKMZlDlgDfDSYw8Bdm9YQidwmFk1oaweK/1tNM5L9loIBmE2oE/RvcXdzMHM23lVetH9TvhL8Hg8O/gxfxZLDm1VCNQA5fYPBCh0TL+QcIta9hhkWY7wuHdTl3AtQQ6sa5JkDbx26dRVpE6r3nCsZ0sOlJfmRNhE3veTMUyF3iVwwiMm0wuHcxpFlrmPDie+MUrPliaDCoMy6F822jqZwWukhsxhOJtz3L7v4HeXSBraDQYD0RuipRMli34Udfxh5WNOBkGkSWD4yyDn2be15Xc7hASDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anujQiqtOQvvKEhgxTXQRKH6UyRigaoj2hS4DvD0AXQ=;
 b=YyGDBlZKhRs80U3G4ETs9dhO7ipGscwmAdy1+Va3fXp1+gAIhyB+uTF7/BODwNtG5u9yn0s5mW1APZaDiZd0oMOz9/VT5iuVEVPDeLQIPgtRIGnyTrS9OW8k7B+J0u/b9tYT3RJGjGcWqlGLL6NnPKmJQsRud0IwGqnScn/rjEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB4737.namprd12.prod.outlook.com (2603:10b6:208:8d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 15:04:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 15:04:11 +0000
Message-ID: <cc0d3857-0839-00ae-e820-863e02d07549@amd.com>
Date: Wed, 17 Aug 2022 11:04:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: add family_id property for kfd_node
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220817030926.80377-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220817030926.80377-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0a25d77-d6c7-4aab-8bce-08da8061bdee
X-MS-TrafficTypeDiagnostic: BL0PR12MB4737:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0H1JCcO0ciNI0OZgf/jp7Pf+M6iAsGrXE/BZdH0LLh8JXNyWEvdkYQyUKhGYEkJ9+x1Rw8EK7MRu1fJBQ2pqYEc4jLpEOKPxADoLuTylXuRUKZbyrJv5+gCeXpcinO6cu5aDWHa5TqMlLmaTxpfCVsLz2B3wbfeSyeCQXUyIIqx+Tgq+0/YAPOCGn2gmqPHRmvU6Br9jwIb8N9VVOtgI1gHZhKunMwJhl04B+7Gl4qI4ZXB/dOR+S2JogC49WWjiIkIp4tgRGsmK7DEaU1fGlTZi7eG0wl+jV2eCwen4k8EIa3zjhph0zttxVblUshPciAM+UJIwZCOmmmVlEpa0zkWmutjVy/0wihoC6o0Kzad6KO1uQsAm/+v85RUbFAsINp/YGfaiUv4xcHSKnWA0fPIakpDqkwJT/j1W6ha7BwdK0T8lTkm+Mqy4sq4984y6MVnU7NLqAQyUg2DQYlVlBVRFQl1cwg25/836aEZpGydF5fyi7orPkXszJc8mGu8NFZ4AlC1cu7oepz1fw2eVdHlYwM1TkXbqRBb7xM9yUi18HHvOkMXW96a22sqjM02XNndRfhmcOMVBTLixJXmvXRAg67qjqmrQcMeYkh+48pQrg6dnH3x/P4fTpl9s8RqZP4W5TfwINYLUekheGUVNj5wsrvaL9SwOToxdXZyllSHYM6jysH7qFtwXXcyFUrIHwklH/bTOSzan01/dz223Kvq+rMLGDoios84zMn789ceio+wOzZp+IbH5JMHfNaVylBfqrKoD08NGCoYNdlCOwv/6cJgHwuauUWIOO/k9rvml0FtTCWzoFiWTG5/TyWVNhmUXTq0tqMZLov+r7+GcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(478600001)(66476007)(41300700001)(2906002)(66946007)(86362001)(6486002)(38100700002)(31696002)(316002)(8676002)(66556008)(8936002)(54906003)(5660300002)(44832011)(4326008)(31686004)(36756003)(186003)(2616005)(6506007)(26005)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alVJb241OVRiNkVpSXA2MU9HZjErRnRrTXFKNVNreWxIb0FrV1pyUkY1MTZC?=
 =?utf-8?B?bE1maUk1Y1Vha3FrczMyS3ZYSUdQM3JzcHJ0SVVZK3JyNDQybUozUm5taXg4?=
 =?utf-8?B?NU9RU2IwNXpPa3lwbGJkbFFlVGJ5M3lIbFZIZE5JQWVIMWcxNGxYcXFFTDg1?=
 =?utf-8?B?Qm12ZVppOVIySTJaYnhkOWNjNU9QdW0rK1VrdkNxVzhPOWNDSnk2eThrUUJI?=
 =?utf-8?B?L1lPQXNPWlpCQnNHT25UcW1yaXYvcGRZajRHTDRnSzJZTXRLT1lJaUYxdk9n?=
 =?utf-8?B?bnkwK2VyZ3ZYMGU2WEFxWHBOSWJKNytvc0w1RDZPVTVWK1k5MVdvdkl4WUk0?=
 =?utf-8?B?OUllQ00wWDR2WUhXdHViQStNek5pNnlCWXUzZG9JdE12RmVSREVVM0pmVkFH?=
 =?utf-8?B?YXpGMWhOK2M1UlU0dFMxU2ZuUHZyRWhROTVDaFp1UEozWWJ3aXpNbmVLTW43?=
 =?utf-8?B?MFcydUZWTkxiQTVwYVpBeTZreXdoU1k4THhLRkU5SzZzMHdaM2NWNzIwQW5m?=
 =?utf-8?B?bWhHY1FzeFl6c0Z6NnZGMXFrRlVZRGJkeXVBdURvTWx3OTJFTS85RHRMM2Y3?=
 =?utf-8?B?UG15SVJucm1WbzBMVi9ycm9LOENldVZoODhBWWdqbXp5OVdIai9BdEtVZVVP?=
 =?utf-8?B?aHZsKzh4THJGcXhYV2ZRY0JLbnhRN05xbHp0T1d5eTFncjNUcUkvYWhFa0Fy?=
 =?utf-8?B?VTFzNHhJWERMZ0dwSk1CSHE2c3dqVXRUUXdTeDJLQXdVQTRjdkd0QVNOTFAy?=
 =?utf-8?B?cmxEY3BoNlJhaEZMbTR1VnBoenVrQklScjl5TWFDb2E5RWZTRDZ1cFRtblRC?=
 =?utf-8?B?RVRZSkFlLzZmRitObkE4MWxucVJHaGFuMHd6eUNKTDNzQmFUelYrUXBKcWtQ?=
 =?utf-8?B?a21Ic29ocERSME83NGVYMFEwQjJjWmtCMHVMUFVtSVNSOXRoSmliSnI2bkRv?=
 =?utf-8?B?RzJja3FXN2xYV1ljWFJjRHY0WS9FWFFSeFZBNlArMXpzYXRPbHFLbld4akVG?=
 =?utf-8?B?c1YzRktyait5R1kvQjkvY2d3VHZtTzAxQUNZSHBJYnRoNG95Mnc1RCtRbHNn?=
 =?utf-8?B?NnU5NTRDaGZnTjlYaFJ4d2NzMlZ0YnN4MEZJRWlodDFCYUpyS0daeFJ5T3Jn?=
 =?utf-8?B?bm1kZkUyOWJLelk0aVcrRmFVcmRvS0NsdnJGcWVKcnBuaEZkNnlSZnI1RXU0?=
 =?utf-8?B?VFV1SWx2ZHJoR3hVdkozSEdmNEMwb0JZZ0hUeVoxMzNaLytLbTBodlJhY3Ez?=
 =?utf-8?B?b3A1VEZ1NzBnZzIrb2UvVW9NWVlDRE9oWGNzSVVwQS9HK1BRV1ZtYWJBTWE5?=
 =?utf-8?B?bWcraGQvOUpsMGpkSmo0cjZhYzB1SWlXaE05c2c5RGVYRUxwQlQ5TnlWZ05s?=
 =?utf-8?B?VnhLckxkR0laNVNRWDl6QnhXQUtwY2VsdXZ1ZXBiR0RTVzFYRUI2cExoRUpK?=
 =?utf-8?B?ZFdwS0MyNWo4UFhkSW51aFFwNS9meUU4ejZyRnE1QmZVRSt1ZjJiK0pmWGp1?=
 =?utf-8?B?RHFTNytrOEoxa2IvNGxDODY1SHR3ajN0VStzWXV5YnNycUl4T2lZUlY5R0hh?=
 =?utf-8?B?U3NoN0dvcTM2UlorMko1U1hnZXkrcmRKUVdJTzBsMTQ3eDJsd3EyZDlRcE1x?=
 =?utf-8?B?aGw2NXozcVBuMTlWcG9MZUhuYUIwU2RYbmNzVGZIaWpCYzlUZDljRHZmQS83?=
 =?utf-8?B?RFdKa3drUWdyNmhuenFrdU9IN3czYUFXNGd3bFZyVzh2Q1pwYTJjZXZEbUVj?=
 =?utf-8?B?dWVYeU9RenFiNlJOL2MvZmxob1A0RTUzR3k3MkZTVjBjL2dFNzRlMjlPb2o0?=
 =?utf-8?B?SGN1OFJzaGRiTEpYV1NJVy9tODFzM2pGbWNicmFmV1NvVllXbFAxOUE0eHRE?=
 =?utf-8?B?ZnVneVFSOUhXR2x6K1g2elJXemF1aWZQN0pQWHZyNGpjUDBpSGFMVHg5K3M0?=
 =?utf-8?B?ekI4UjVBRXhleWk4SnFFd2tCalE2NTR3cS9kWHV0QWZUaW1jTkJmQ2RWcU1E?=
 =?utf-8?B?TW80NEVrS3JDL0pTdmxPaEFSbkJJRmY5VTZ1KzBaVU9UelVuR2Fkd2tIdldM?=
 =?utf-8?B?RS9pMHFtMWdBOXhUTjBhUmVGRFdSRHNNUlZXd0d0TS92RTNKeGVvVVIxaHNX?=
 =?utf-8?Q?Wq9pw3NDYvNffilrzJOMVx5q9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a25d77-d6c7-4aab-8bce-08da8061bdee
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 15:04:11.4462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1C6113QFLmCtNv/n9EXK622ZcxS+uaiApq/uA9dcZ+eR5F4eKHqW40+nW4tnf2Fstjr/PEeq7vFdhBGfvFFT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4737
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-08-16 um 23:09 schrieb Lang Yu:
> Then we can remove the burden of maintaining codes to
> parse family_id from gfx version in rocr,
> i.e., remove DevIDToAddrLibFamily().

I'm OK with the change. But you won't be able to remove 
DevIDToAddrLibFamily as long as ROCr needs to support older kernels that 
don't provide this info.

Regards,
   Felix


>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3f0a4a415907..7e0331e853d5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -507,6 +507,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>   			      dev->node_props.vendor_id);
>   	sysfs_show_32bit_prop(buffer, offs, "device_id",
>   			      dev->node_props.device_id);
> +	sysfs_show_32bit_prop(buffer, offs, "family_id",
> +			      dev->node_props.family_id);
>   	sysfs_show_32bit_prop(buffer, offs, "location_id",
>   			      dev->node_props.location_id);
>   	sysfs_show_32bit_prop(buffer, offs, "domain",
> @@ -1690,6 +1692,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	dev->node_props.gfx_target_version = gpu->device_info.gfx_target_version;
>   	dev->node_props.vendor_id = gpu->pdev->vendor;
>   	dev->node_props.device_id = gpu->pdev->device;
> +	dev->node_props.family_id = gpu->adev->family;
>   	dev->node_props.capability |=
>   		((dev->gpu->adev->rev_id << HSA_CAP_ASIC_REVISION_SHIFT) &
>   			HSA_CAP_ASIC_REVISION_MASK);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 9f6c949186c1..4ff8dd2c9549 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -56,6 +56,7 @@ struct kfd_node_properties {
>   	uint32_t gfx_target_version;
>   	uint32_t vendor_id;
>   	uint32_t device_id;
> +	uint32_t family_id;
>   	uint32_t location_id;
>   	uint32_t domain;
>   	uint32_t max_engine_clk_fcompute;
