Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE6EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F7610E572;
	Tue, 15 Feb 2022 14:15:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4FA10E572
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 14:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAHPRV7IyWhi8IEAT/v2OP/aPH0A9Xq5YfRYB6Q4mLCqr0/Orn8qTlYMRRAZRcVZ7Clyrch9VIpTUi+dxuxX7+LPt6Vx3y4xnb9KlgA72v1JanrIr/oeOgWqWSzMTYdt7xF0YJqaD+2KaeTUzR430RatI2+x5q+dkPpkseckieZh77QSnIl8eho+mqMS3tnAWTjuN66u2MzOtcXRo+ea6u+8BaU1+Ta4SPRX76AP9RL4K2VIEZWjdxSGu1eaY7aQ5xrIn29Zgx/WnS2aODBq0k7PFpAXXT8pB8xkLQlfcj5Fe/GCj41qn9QAKXWSkwWNlHnqyPvHzHvdMeucDcWIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUD2CYPCIeomnO3aaMLSvC4wAWv/eeIDsZk+JsJujtk=;
 b=QMMmdKOM9MSrG2HGSxcHp+o1ULfW8FeMlvKMpV1i0LGhQUM4TljO69jfOs25aJZrM5EQVB4e+KpAjIbBVRuVAlc8OEPk2RWqrwQqPvdXxWOVE4PUQVPU1/nw/VpAr4n+/ZzV5uBqEYgTipxV76DawZK/+11k8NaxofsoFFG+MYnaXI5vKS4evhyu0Xy/LrBSZkt+YCIP0iCcnTDnLYItKyE8D5ouhut22fG7sEI3YWk8m6W0QjIhzZ7qpA6DSOJ5awlOZ+kDvm2KPrUaRApz3Ut/DGx9OiF/5ogEYA7aTcGbXZ+ONWK1SUbrCjF1/YX1Ui/s7yXXRTt8faE0cG9bYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUD2CYPCIeomnO3aaMLSvC4wAWv/eeIDsZk+JsJujtk=;
 b=zIGxVEO0KgNWqMuP5ZCsXgKxdAvVZ/AUY1cpyGdchDlqhcpuGg5h12G2bf5YxTcJP75tpTeDIkzp9NkZCWL/zzKPNjaBGSXbeF/jNe7Uw3d0tlQavCzqYfahYyJCgSiYvzgXSchXY8aNBI8dCUtHTQalXtQCPGyFgdAENLpYyxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB5551.namprd12.prod.outlook.com (2603:10b6:5:1bc::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Tue, 15 Feb 2022 14:15:43 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:15:43 +0000
Message-ID: <075a73e7-806b-a47d-1c52-bba2e35c1b0a@amd.com>
Date: Tue, 15 Feb 2022 09:15:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220214231857.5129-1-luben.tuikov@amd.com>
 <20220214232154.6421-1-luben.tuikov@amd.com>
 <BL0PR12MB24653E696EE8C9F3E635AC7BF1349@BL0PR12MB2465.namprd12.prod.outlook.com>
Content-Language: en-CA
In-Reply-To: <BL0PR12MB24653E696EE8C9F3E635AC7BF1349@BL0PR12MB2465.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 529ebcec-3586-4836-d56d-08d9f08da72d
X-MS-TrafficTypeDiagnostic: DM6PR12MB5551:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55514DF02BA153FFEC40FA1199349@DM6PR12MB5551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unoZVXwr/iYC09DKRSJJpV17Un2AbJDYWS7kbp4No5UgXRlEwNYhxPBgRhcHhj/3T/Nl+B7W0VAh9Jmih5r26Mejng7ifsDPjFE+XQe7xNg2bxSDtEXcrUV7/19tYYXvojjGtU+vn+KzLJVstmW04zgWz1iqzbUvmA2m8vq9NPdzPEccpBYNakePCMhj2g0keZQEI0IL/UqF5GnREldyIM5j0S/clZiV26U0Sg8fWi1gGEbwIxR8JjceJWaS5KCmGk8gZBg4aTsbDu5KYTV2cJRVsSUg+su7l3HYoiix1rEE6S/3VM/sTVJUwrOQ0NT51p0K4COjxNiKLAhQfODdf073ToGHqtUr5ASTYKOEidrN9GDPa18VWWmfkVJzNHbzqSUY7e9lVf880mJdAK2uFRg0CEMUISdCwJ0n54fT5rsTYdYynd2/zY3oCU3c3Gwx5EpnvkE/fiEIJP6ZhNwCNAtLytzRvKzHPBMf5AFq8G5btAGCrr6HhWKg2BEt8Rp90lm4fHcmp3UOoe8e05yMJY+ezZlP4yviICwKUsYSkKtcel+VoNzClSp2VNhvfuK1UfyBeYNf+nuLHeaWnqyqhXYVw9Ibts5DDY9xT03tNHthTlBQdslBUcWK7rMPSzuXsPSpHefQScSQZinyUWjgzmFpfq/FWu8k0J+w+RIQLCb1zpW2E9E1glYHcxz9ZUZxjtbZL24jWqfv+DxB8y2hTfK7VWpeWD5waE5GJ/c4FKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(6486002)(38100700002)(5660300002)(8936002)(26005)(53546011)(186003)(2616005)(2906002)(83380400001)(316002)(36756003)(6512007)(31686004)(66946007)(6506007)(66476007)(508600001)(44832011)(31696002)(86362001)(8676002)(4326008)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjhLK05USDJWbkwxR2F3K1VBRzZPc0pYZ1dzTXBrQmswdWdMRk85cEJuQjFm?=
 =?utf-8?B?RzI1WHVlc2src29RU2ZmMC9qOGVqbUZKQjBsbGRid0w5UkRBY2h6Yjg5blpy?=
 =?utf-8?B?WlpmekpmNkRHZUtrNEpIbEVjTVluRzMvWHphQ3VmU1pEYURHSnc3Tkp6Y2Nh?=
 =?utf-8?B?WnlUSUQ3Q2Fvajl1aXVVdks3MjJMTWxnZXE3VWtPR1cwVko2Zk5TMFV0VjFT?=
 =?utf-8?B?c1c1eCtJTkJxNGRleVdpbFc1eVBlUmp3M1hyNkdNMDAzamZsbGNxemc1YjdF?=
 =?utf-8?B?cU1ESTFrNU1YcWpVSi9HdGVmb2hyZTk4QmlTZjcrRUxLbmFkbTU4VlhWRnBI?=
 =?utf-8?B?RUJaaWtrb1A2aGZSc2I4a0RmeFVoUzE1RG5NTlQxOElnK2J2Wk1TT0szdWxj?=
 =?utf-8?B?VzFScmRaNzRVTHhpbHMxbGJoQmkybUx1a0NRMHlralFHbko5aEdHdDZsYUlk?=
 =?utf-8?B?U3dBSXdOSHoxU3ZtWXJFR1hLbitOb3RIQWtmQkE0TFhsU1Ivd0hhT0Y2R1Rr?=
 =?utf-8?B?cEdGcXRRV1Mwbzk5bHJncHBwT2tzUGVlMVo2aXJFTDJjSHU0aVFiOFpYZDhm?=
 =?utf-8?B?dXQ4TEl0NjBWUTVLU1VkVGhLYmI1QVpKaU40VnJGdFYweVpkcThGWTJUaTA4?=
 =?utf-8?B?L0pSTWJZOHV4Z2l4WHRtL3oweU1PS0ZSS0dGczRsUlh4RlQ4OGV1OVY5ZUJY?=
 =?utf-8?B?a0FaRlVyNzF1K2VkMkJGTGdUc1lxMlYyWHNJMVZxdTc1cHIxREhzNnVhVWc4?=
 =?utf-8?B?WlJaQ2J1RTdqQ0pxWTNUdE9MeU1WLzVneXl1MHhWdExWYzA5a0tlNDZrTjBw?=
 =?utf-8?B?WmV4b21hbVF1alVOU3VLTkoxek9wK3Q4YnhuR1gwTnFBVmNQVmJIQmdnU2Iy?=
 =?utf-8?B?ejZkN0dteHZkK1pYYml1aFZVb3IzK1hReWZrUTBuaTAwb3NWbitqaTFQZ216?=
 =?utf-8?B?S3lnK0EzZlR5MkJ4Y04ySFQ1MzBUQ1lzT1VtcG1FQlA2THl5ZHZxS2l5Tmgv?=
 =?utf-8?B?T3grQnBuYTY3MnRpbjhld09kNm14WW1oMGg4QStGd2lseFBGVzlna1BGdnFC?=
 =?utf-8?B?dFZib0szU0lWNHpKNnk5QXJNQVVVM3pZdEk5N3dVS0pGYjBNVTljam43T1ly?=
 =?utf-8?B?LzFiblVSSzQyRWd3Z0NKS1Y2dXJWOFoweDJOT0FGM2VRMy9XZ21UenYzQkdY?=
 =?utf-8?B?QXZocCtRMzVvTkIwMGE5S2hqTWtyeW5hRFVRQ2xSOFhjWU1EVjcyZm5GTVN1?=
 =?utf-8?B?VHdIMnREbEVLNW5RU1FxcThKaG13WmFiVml3QWZQeGYwSUNFMFpleXRDazhG?=
 =?utf-8?B?RkpHVlJSL01uYUpzeDhUWWsrM2RwRGpmN1B2VGpTazhtQ2VvM1YzOXdqb2M3?=
 =?utf-8?B?aDFvZHV4eHJOZ1hHS0tCWERNVUt0OW5aTVFITWUvelBQcjJHc1V3TlA3L2Uw?=
 =?utf-8?B?SnNLalp5ZkRQUXBmdEJjQzFGbDN3V25ZT2V0RVk3WkEzNjR6RElkWERWeDli?=
 =?utf-8?B?RWdpUm5IWmUxYXVoZkNxenAwTzZ0ejd6MUUrbTJ0SGZSQlZSV054R0tIMDNP?=
 =?utf-8?B?K3ZxOXU0WGhZdnhPTHR4TVRxcWNhcTZtdDVhNktXZ013cmtqUGh6aWFzK1B4?=
 =?utf-8?B?blYrNGg2NnpwSzJsYmFrazBrY0hoM2JOMVE0c21hSWd2Nlk4WTdqVzdkRUpt?=
 =?utf-8?B?WHp1cVJ1OWxZQ1MvZ2paMWE1SzFmZ3pFdDBPSmtUNXBoVS9iNUM5bUdscllI?=
 =?utf-8?B?YVJkRGZuQjU3S1ExU0UveDZTZy9sb2hzNGs3eE5BUlE3c0w2dnhHanlISmx3?=
 =?utf-8?B?WnBCNmVISldWeThkUXU1YTlWTEh4ZGV6MXg3clFBcS9MWTJjVnd1a3JyZ0Nn?=
 =?utf-8?B?WXVkalVUbytDOU5lK0Z2SWl3SU9YQkwzNDZ6azZhbEhyZTBBa3F6cVJUQ2hE?=
 =?utf-8?B?ekl5RkR1TkdtSFZzaUpiSHBVazlTeEM2RlBad3NMdXk5OUNhWVRGRkRVZFk3?=
 =?utf-8?B?dFJvaVJoTnh0VnB0cnU2SDlZVElyMmhXeXlMOGFqSWNIeE9QR1hKUTd6d2JF?=
 =?utf-8?B?VU1xRU5wM2lvV0JIa3lUWWdjYnM4L1VSUkRxNnhvclc2alAvdk8xeE4ydnZs?=
 =?utf-8?Q?RRMI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529ebcec-3586-4836-d56d-08d9f08da72d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 14:15:43.7676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pEDfdTWqRv09SiGEh8uddE+kFSg7YK/ZWojSqoeH+lGVVsKHUa7+dTHXENYLF6L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5551
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

At the moment it's 0 across all IPs.
I doubt there are any consumers of the harvest data at the moment.
Since this will be fixed in VBIOS eventually, I suggest we add it now for completeness and it'll be there when this is fixed in VBIOS.

Regards,
Luben


On 2022-02-15 03:58, Chen, Guchun wrote:
> [Public]
> 
> Hi Luben,
> 
> I suggest holding on this pls. Harvest bit per IP data structure from VBIOS is not consistently correct. Exposing it to use via sysfs may confuse users.
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben Tuikov
> Sent: Tuesday, February 15, 2022 7:22 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>
> Subject: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
> 
> Add the "harvest" field to the IP attributes in the IP discovery sysfs visualization, as this field is present in the binary data.
> 
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index c8dbdb78988ce0..0496d369504641 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -393,6 +393,7 @@ struct ip_hw_instance {
>  	int hw_id;
>  	u8  num_instance;
>  	u8  major, minor, revision;
> +	u8  harvest;
>  
>  	int num_base_addresses;
>  	u32 base_addr[];
> @@ -440,6 +441,11 @@ static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>  	return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);  }
>  
> +static ssize_t harvest_show(struct ip_hw_instance *ip_hw_instance, char 
> +*buf) {
> +	return sysfs_emit(buf, "0x%01X\n", ip_hw_instance->harvest); }
> +
>  static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)  {
>  	return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses);
> @@ -471,6 +477,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] = {
>  	__ATTR_RO(major),
>  	__ATTR_RO(minor),
>  	__ATTR_RO(revision),
> +	__ATTR_RO(harvest),
>  	__ATTR_RO(num_base_addresses),
>  	__ATTR_RO(base_addr),
>  };
> @@ -708,6 +715,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>  			ip_hw_instance->major = ip->major;
>  			ip_hw_instance->minor = ip->minor;
>  			ip_hw_instance->revision = ip->revision;
> +			ip_hw_instance->harvest = ip->harvest;
>  			ip_hw_instance->num_base_addresses = ip->num_base_address;
>  
>  			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
> 
> base-commit: d8604f1d237a145db48bae4ea60b85a5875df307
> --
> 2.35.1.102.g2b9c120970

Regards,
-- 
Luben
