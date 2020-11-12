Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FBEC2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 15:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0555220A8B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 15:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tT54mb3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0555220A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1CD6E2BC;
	Thu, 12 Nov 2020 15:23:32 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700044.outbound.protection.outlook.com [40.107.70.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE226E2BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 15:23:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEDTeTvNoNoEzpMmG84YYDtYknS9bjfs+BTp4SkjMa0URTC310CEMSFC4bsXBsUWzhAJRW/Rz5yjUbBxfuaK0DzM/aqfEV6nHawJfnHoZe38TzXJYSIqyPVzegTA4BsxckHp4Dwtl7cab8nb1/8TeP/5TrZ7OfGYcAIJtN2lqhnM0Cjl9iTzh6tF7h9wLjemOmKFp/tPzp4v0Zy4iheREEvgA++v+jNojmPZlOOEVe414EzeaWUHCwlN/O/xcCLz8htqrbPE8K16DYdVsdL7AO8PApVUGpYz4wBtXe2PBFmOE/YMYvNJewbxtoXxcOMHgHpilqFq1kvfGhCNZBCCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7tm4SDHexKELqFXZap32y12JwB58E6IoErJmp18QB0=;
 b=EQTXkSwBd/wkhswk2/miA1CrirYNyYerSoDDbJUIiDhvsP2EstB6a6C/V8FJGS8zbrYqD5DNzMXIxao5H/vwfkMHe7a+Yt5ftl8urZ/tObM2c2NvWJyL8phWhKKjQOMFcRttwvIdXFgj4KBqUO/Y2P66h2X3+69YyQ+PadPxvGyEpv0uF8DSIEZnnpS/49Trfis3sWg3NX1bcvLwQ/ic+hFKcHquKeEgr/U8RlmfbmHIN/rwWiO9XV2kePZQlEML5B1Mn2oUGRy92zh21yqt9GxwfS1VZBW4WFUigL+JJL8kG0lSIUw9tUuiL3FHHzGmE69Ez3abZW9J6j9vY5asRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7tm4SDHexKELqFXZap32y12JwB58E6IoErJmp18QB0=;
 b=tT54mb3y6NDoV6m8237WSkFs9sH2R1bPlIvloncFrA6fHx6vL639eI1DleMDRvOtlc2cgl5Lhl4J7PHa9Fgih8WqDfHE0xcEBv6sKj+Ea/06EUUMdda0NXHH6lFMeB8CUyOWkK4RbEmj/q/WvMnTx4By5AR0hv7CsfXVccwqVY4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Thu, 12 Nov 2020 15:23:29 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 15:23:29 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: add vcn dec software ring enabled
 parameter
To: Alex Deucher <alexdeucher@gmail.com>, James Zhu <James.Zhu@amd.com>
References: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_OuXH4iWR7baRsUDTO3BMe=TditrXgCqvzC1U_pb27saQ@mail.gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <9971c116-faf9-7ebe-0b59-4ff1b5cd25ae@amd.com>
Date: Thu, 12 Nov 2020 10:23:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_OuXH4iWR7baRsUDTO3BMe=TditrXgCqvzC1U_pb27saQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::22) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YTBPR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Thu, 12 Nov 2020 15:23:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 412d4447-3d5e-48d0-3431-08d8871ee88c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB420199FF7C7E554DA72F378CE4E70@DM6PR12MB4201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQvyYer2dQ1oIle0yO1bOgYZK0xdCo3+qfmdET/mZE55gugeX0LqKKDiVL9JOWDIQh3LIqA/Y9Q77x/hnVcxT+FPBLQsBopTO89I2OQ5zSWORVX1FydlMn3TbFI/bW2jM7SNW+AE0SGzYCzvkVXT9VaurVAoEonfRZscZA3YfZI4GBIdF2i1rIOxrXVmJ6OWGq67MOJP6hr7F6fRr3AEWhW2i5cGGSoV2QH45xvkGMXla0OwHbMKAoPR61+tPrJevvxzw0vDBxe6Q9Nb+CW13OUwysZysNbx1wqp3M6N45DPt21Uz0Hq2n6ymOXuGDawBLqemzkPxUlmNGYaduvH0m9HN2JlDdfSryVF3q9B9ajmxNL7AKP/lnGRIZMVk/1Nuc/RPwIpyUOp2HOPOyINNDc6RKgizFSsY+D2ur2tC5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(956004)(16576012)(5660300002)(31686004)(316002)(6486002)(36756003)(186003)(110136005)(2616005)(4326008)(16526019)(2906002)(6636002)(66556008)(66946007)(66476007)(31696002)(4001150100001)(45080400002)(36916002)(26005)(8936002)(966005)(8676002)(52116002)(53546011)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rs0rXNdqTOOc6jpi1MjCtEnIKxV4gK0fmInIv36AXr+hcGkfRz+3h0adsecNrjd/cpH402BOVm2kRojbKoyk1LSgYsshsQdTzuU4kaUWr+bqgg1EnJGncEW9vuCZ0ywrlgBpTH2S9FAl5eHXVDhsKT4tgW8rR29R6mKAd1kSKKVRfkiKRliqh8ibdEi3NYoFX+ouLPN/Cf1v6fmjxNM2eTuqBmkUAlZwcqJYplNr6v4OcwfuMorDNVpzWD0nqj6B/vztqAJPfGZg6/YzTHheh33rLq8XZq7h700kyOo9Gin374uwDdqmUErjEmjfZr6Ve5Ft/yBg/IBX83zlC5TMcpumGoufwY1eKwYVohCplJ+5KlB1s7OtwxQd4ecNtrOLKA8Pm+LJB8KnmP0aZ0uN+6iXhGzTxjagxnPTb/QLkwMiFwS3i1WLUCmqIctp7owlakDfFapYi0d1RvjwYDrw4LZuyP3yjh6TfTnLVOfxfrZb9B2EuDadh0yS/RLNY4fnymKaAssCXzm2h7dH4QUGLT/TJ6zfRCkgorcdfNz6NeyR+Xu4lzrIHmwwcNoGaNqSsdtHy0RK4uiMO9/mkf05UFhcUst8LI9dtzgqp4RTeziARc2dYLPQbLqxy2QSpyTpcXp6s9/P6TOWWM8bAkq9B8R/UOzMFkXw2qdgojEBbmmhpmXXS/Q0MghUs9PV5cs/AZmuW4XCPeKQOnhIunNJFoWS0/p13JcQTQQ21AiHlAspK8iLy8r67Zb78jhRbx4HPJ5bVKnXgtYKQV13cem5nW6nN4hSDCPLl9b7gyaJuJ59JqKjwziMrpTqSkE/forGq06uBKM7WvjentZOMiUFuGNox7gMAMR5tqiaSmCswC4cueMUjtLXV0ZX6S/MlXGkt5GH4CZ7TmOg740SNbTq4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412d4447-3d5e-48d0-3431-08d8871ee88c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 15:23:29.5015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: serhjLyB0/O5H4VvdQ/vpBAieRpDvKb4eK0nmPMMxI+0FpfzrOQd5bxee7nBxOyS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-11-12 9:23 a.m., Alex Deucher wrote:
> On Wed, Nov 11, 2020 at 5:28 PM James Zhu <James.Zhu@amd.com> wrote:
>> This allows us to enable dec software ring feature on VCN.
>> The default is 0 for all asics, and it is only valid for
>> asics with vcn3.0 and above.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> Reviewed-by: Leo Liu <leo.liu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 20400ec..cc47da6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -209,6 +209,7 @@ extern int amdgpu_si_support;
>>   extern int amdgpu_cik_support;
>>   #endif
>>   extern int amdgpu_num_kcq;
>> +extern int amdgpu_dec_sw_ring_enabled;
>>
>>   #define AMDGPU_VM_MAX_NUM_CTX                  4096
>>   #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 999f84d..570088f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -160,6 +160,7 @@ int amdgpu_force_asic_type = -1;
>>   int amdgpu_tmz;
>>   int amdgpu_reset_method = -1; /* auto */
>>   int amdgpu_num_kcq = -1;
>> +int amdgpu_dec_sw_ring_enabled;
>>
>>   struct amdgpu_mgpu_info mgpu_info = {
>>          .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>> @@ -806,6 +807,13 @@ module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
>>   MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
>>   module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
>>
>> +/**
>> + * DOC: dec_sw_ring_enabled (uint)
>> + * Override vcn decode software ring features enabled.
>> + */
>> +MODULE_PARM_DESC(dec_sw_ring_enabled, "vcn dec sw ring support (1 = enable, 0 = disable (default))");
>> +module_param_named(dec_sw_ring_enabled, amdgpu_dec_sw_ring_enabled, int, 0444);
> How about just vcn_sw_ring as the parameter name?
[JZ] It is for decode ring only. if just use vcn_sw_ring. I am not sure 
if it will confuse people.
>
>> +
>>   static const struct pci_device_id pciidlist[] = {
>>   #ifdef  CONFIG_DRM_AMDGPU_SI
>>          {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJames.Zhu%40amd.com%7C6a8168ed39b74d9a0a8f08d88716a006%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637407878530324835%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=egZMRoAdhY%2FRQAVENCT5CEVivi%2Fdzsn%2BUxPrnHJRKzU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
