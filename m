Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2FFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 09:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A0261153
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 09:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57A0261153
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A3B89C53;
	Wed,  8 Sep 2021 09:30:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0892B89C53
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 09:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmV/BHAcjcnwCB21Xy8yPj3HGBP4cxsvcfoLEuhqpGTFpPbHyGVNTdrWxgOUjJs/5Aog14duOqAcVIigfTPkYoOeH3ypkKPu4mmW2TkD8WJTPyO9qJk1DuUwH83Tvc95V0amuLqYHVbIHDcsXqgE4a5gMhd/MqMWEppWD+mQ9cwD9rGc7oCthk+rOkOBV4/v51hmIPiLUMqeZtLN89khEcfNJEgSwOLZaXSOy1KzOOvSogdJLkZhu0OdVQ/VwervbeXxToIYRioiihphpDzI8e1lPty5Ka32VUXL+qK+WlN3iJgbR0UzeCQ97Tns0fOFCh7+MJMVjWD4Btu+CJ1EsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=gro/qndIFNHtPhaBlOQMKEBbrniQlTlpW9aPXIvuymc=;
 b=k/VlnTGE8YvLtPYcYIfRDXuabCS00qGeNHzCvOoICb9CJg8nP3fhATWt8F3Oio8A3rGgF+6CthY5AohstACs74VpQ+FZ7Mn8iY8czI00l1wkBkt3NHirie7JGUd/vzW64R4Apraj9+RYgVXtUfTtmraVFz/R6kWyWHZAJ0HRwsGwe7iwacnOBIDoa4CvTSIugvdM2rm6zQ6uqIwyA17+Qq7+7elU0d69jGWnUSjEZSsQLM1KpivyLGpi4PDbOu5fsmI0mT5YniB2tDVehoun6bhOcA/L79BC4n2OBKxjUMCPJxNsPdqWAlXUn6g/RJ0D+vf0ZXtivkOqhbbMu2r4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gro/qndIFNHtPhaBlOQMKEBbrniQlTlpW9aPXIvuymc=;
 b=oXc8Rm3VlDkuHQG2J6gKdBe6xSOQzNe2svhuAZX3GLRWt66k/dePh7dPZ2YmUlHDfV9QRHAYuQd7n1AnjVUBejEBl05ZJpnMJuwyxX1r2i3sZ3lPMxTq8NZ7vCHox74g7mVcj14v1LfmiYPN1dcAwI6WJ3FjcFZ9w6Ozz7/rOY4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Wed, 8 Sep
 2021 09:30:07 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.022; Wed, 8 Sep 2021
 09:30:07 +0000
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
To: "Yu, Lang" <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, Tian Tao <tiantao6@hisilicon.com>,
 darren.powell@amd.com
References: <20210908055615.3781901-1-lang.yu@amd.com>
 <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
 <47ed143e-b9ab-a80e-dac0-cfa1ec39d033@amd.com>
 <DM6PR12MB425086A1FFE0D1609581DFBAFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <39d2443b-c90e-b5c6-85ee-b44bbfd818d3@amd.com>
 <DM6PR12MB4250831801024A782408C280FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <332d81e6-a518-a155-cdfc-008e0bdb324c@amd.com>
Date: Wed, 8 Sep 2021 14:59:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB4250831801024A782408C280FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 09:30:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76448511-4a0e-4413-9857-08d972ab3ed2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB538464E23272E2E3D625CD0797D49@BN9PR12MB5384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GECoJrOKD8a3SFrWRDRNUnXJkocgH621+WfsgpxHh7h5WK1cnEkSSVu8xdcLIOEeBbAhcqMMjvwoyz1XeXbJDWQHOpLvBEs/ZBp5lCjhrTTphTb/HZ9OH/gmkkywLmPzrhgZYcKERC0ec+TNM/aHuelw7TnoZBSGOp0HvyoslgYNPxgCR+U9D7aIcmWPniwllyDH2gQQwQQgtT7L7J6JfQbIFlNMIR2rrqiNTp2597BRy7dxpNTbOGoJxeoew9HLrT3g0/TFOGI7UREi7z46au3Mf9SoYuBNlqQTv05ONOlqqI/GABAWOCUCDiTi2U7HuPE49KU9bdnh5kbmgHufyCkzxPcj1QRD3yyCBS+DnorXz5rQQs2xvAiOX1+yv/Qn+crVlnm/WW5kSdv7+Fh2WFd6eUymweShodyvNCF82sxcTRhK3lFwAmeE2sSrJtHR3X6iFNCrgLsrrQ3WFgVR+pw9IaCjK6Cwqi8zWi0iiyCOZYZUPCZ1kqM/C133cDTuBTcorhzxU8g6YqSdzYKVaxzrCtex1O/WHu5bFyF/n5Hh4xfnskSZM0YHUeBtkdQHARL875Zu8qZYMKJFu2y3kn4uGVj51L4pfUac+TPZVHAuBwmdaR8pQVz/Q3RP+76DKh51CWw3esUpFq1M/y6ADsTv6M/7U37MxWcsNTey6IAHUd9RJ8RzriI9oHTE2TZQuI+lUCW8zSM24o4Std2U5gRHFJaCGDij/NexIHsoaI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(38100700002)(8936002)(2906002)(8676002)(31686004)(53546011)(5660300002)(2616005)(26005)(186003)(316002)(16576012)(30864003)(66946007)(6486002)(83380400001)(6666004)(31696002)(4326008)(36756003)(66556008)(54906003)(66574015)(478600001)(956004)(86362001)(110136005)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pJbjVsRWxXaWhTNjlQR3hmTEV3Z29PWmJBWkI0TWxsNXZLbENsQThNaW9Q?=
 =?utf-8?B?Q2pnbDdydVRKSXB2UHdxdHRLNkEybDJTL1haSlBHT01oVEVWRHlyOS9vZk1I?=
 =?utf-8?B?NXlBSWZocUJudm1RY3VUbDlZNGhIRDRpUnFVY3pKUG5wZW4vditPUnZRRW0z?=
 =?utf-8?B?VGZFTVYxRlJjMUhTRHFSdnRUY1YrZnZWQ0I2UVNUNVZmb2dFZjdhZEhQNE5m?=
 =?utf-8?B?NVFmcWEzS2duUTdHc3ZYa2FqZWJHZFdhOU9CakwrVVVna3k0eUxrTDhqMURa?=
 =?utf-8?B?cmNRZE5pdmVGWm5HcE1IdXl1VUFYTjRiMUhLd0hFU3FEU0l2dVRyeFRuNmxH?=
 =?utf-8?B?WWNhSk5UcFpEdWM3a2tXWEloRFV0bmZEN1gwb2crVExGTnhrUVZGSXEzZnIy?=
 =?utf-8?B?aFV4a2R5b0VGYVhXNnhEKzlyQm55dVF5aW5vcDBWV3hjL1lGalRGYUVDY3hS?=
 =?utf-8?B?ZHRWRFFtdmtkL2NKWGo4TFplekFFanNHTDA1Z2tuS1FaTDJTS3FaQUJHVGF4?=
 =?utf-8?B?MDZnOHEvT1dvRlNXSkVQb2V0QldJMGhmbVUrdUI5Wmd6OEErV3ZMKzJ0VDRI?=
 =?utf-8?B?V1NPQTE3Z2ZGcEhDV285bC9ISVdlbVlwdmQ0NVppWXdEMitDRTRNQzN2OS9k?=
 =?utf-8?B?U290c2lIcFJxbnlFMUhLVDdoekVmTlBtdjFPd0NRZ2RYbUJHTVZTWGVkUUln?=
 =?utf-8?B?WW42YjYyZlU4MFVjL1lWR0Z6SGJURFJlTUtJSTQ2OXdzUHJ6aHlvVGhpWmxT?=
 =?utf-8?B?aVFLdkJUQzE5Y25vZzM5NnJKdkhKZWN4RjhkK0h4czFZdUkwcGhseWgxdmRP?=
 =?utf-8?B?MGw2dHBPM0RaYzQ5OVJYZVpQeDcrNVpNdjdwbUxvMnh3ZG5MQmNmWnZkNHdQ?=
 =?utf-8?B?N3JVZHU2Tm4ybllxQTNmY05DYlNtUWNlRVhqS2VIeW1OUDFvU3pXV0RUcTZY?=
 =?utf-8?B?QkZncFVhQ1V2anJxTS92amMySXVES1ZtcnJFSmNDM2poM085cldCRWhVeSto?=
 =?utf-8?B?MWtDVHQzR1VzUkZJTUx1SVVjYmZhcWFyVTBSQzdlWGlKZ3c3dE9IcllvSnht?=
 =?utf-8?B?eEpIZzhYNFU3bGhVdGVVYU9mUGlRMmpPNFFENFNXRXlCUmVDMUxGcklHRzdz?=
 =?utf-8?B?ZTJTbE10R25IYTUwOTM1b05tRkZWdzFTc3hvc1I3aVhYd05PZGdEb2hkb3o5?=
 =?utf-8?B?c29sVnlQRENLWWN1Wm14ejZ2anYxUUpNeDB0SUVBREQwTGIyTWg0ck96V0Ru?=
 =?utf-8?B?aXdUR0dyWUxMaFUxdDhSY3VCTnplSEN6N2NPcW1YVnpYNUtsZHg2N0FCL1hH?=
 =?utf-8?B?VUhQMTZ4UjNOb1lKdTNlcXhCSy84cDdob0w3Q2F4RUF2bzF5NDFxTDRpYmNM?=
 =?utf-8?B?d0VJNEFjSWV6a3UyOHdqMFNsc2ZNbGxBSE05V2l1YWJqTzBCcG1FQm80cWdM?=
 =?utf-8?B?VkFwV0ZONUNtOERVTHI4UzhEQ09rVHgvbE9XbkdhdHRaWGdXWVFva3Q0Q3BB?=
 =?utf-8?B?cElrZ2lCekhqRmp3VDZXRWNNOWFXYWoyZFBIcFJuM2VPY3dLRWJscjc2WlpJ?=
 =?utf-8?B?M043TjJRS0NkMzY1R3FxVUpTTkp6d0UzcCtMUC9yVkJJOEF4WEJtWFl4YTZL?=
 =?utf-8?B?SjJMNGVpNm9Cc1dQSUI2SndOcENJSEQzeVpJNC9ncmFveThqRnd6ZkMxZkZO?=
 =?utf-8?B?ZDdRd0RIWkgwMkpScUx5K1FaN1hEdU12SEdXRHZIeks3UjVqRE15RkZjOUFW?=
 =?utf-8?Q?hOq8H2LIAKQf+IgQ+ZF5CRAHoPb0U7RWIiGud6M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76448511-4a0e-4413-9857-08d972ab3ed2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 09:30:07.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwvE+ajPwKJK1cDi5CpxW1qCjbzMhRyv5GORg5253TpIfQj0vsYoz0aPjpIzyB/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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



On 9/8/2021 2:32 PM, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, September 8, 2021 4:55 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; Christian König
>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
>>
>>
>>
>> On 9/8/2021 1:14 PM, Yu, Lang wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Wednesday, September 8, 2021 3:36 PM
>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Yu, Lang
>>>> <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>> warnings
>>>>
>>>>
>>>>
>>>> On 9/8/2021 12:07 PM, Christian König wrote:
>>>>> Am 08.09.21 um 07:56 schrieb Lang Yu:
>>>>>> sysfs_emit and sysfs_emit_at requrie a page boundary aligned buf
>>>>>> address. Make them happy!
>>>>>>
>>>>>> Warning Log:
>>>>>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0 [
>>>>>> 492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765
>>>>>> sysfs_emit_at+0x4a/0xa0
>>>>>> [  492.654805] Call Trace:
>>>>>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu] [
>>>>>> 492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu] [
>>>>>> 492.658245]  vangogh_common_print_clk_levels+0x77/0x80 [amdgpu] [
>>>>>> 492.659733]  ? preempt_schedule_common+0x18/0x30 [  492.660713]
>>>>>> smu_print_ppclk_levels+0x65/0x90 [amdgpu] [  492.662107]
>>>>>> amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu] [  492.663620]
>>>>>> dev_attr_show+0x1d/0x40
>>>>>
>>>>> Mhm, that at least partially doesn't looks like the right approach to me.
>>>>>
>>>>> Why do we have string printing and sysfs code in the hardware
>>>>> version specific backend in the first place?
>>>>>
>>>>
>>>> This is a callback meant for printing ASIC specific information to
>>>> sysfs node. The buffer passed in sysfs read is passed as it is to the callback API.
>>>>
>>>>> That stuff needs to be implemented for each hardware generation and
>>>>> is now cluttered with sysfs buffer offset calculations.
>>>>>
>>>>
>>>> Looks like the warning happened because of this usage.
>>>>
>>>>                   size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
>>>>                   size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK,
>>>> buf+size);
>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>> OD_VDDC_CURVE, buf+size);
>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>> OD_VDDGFX_OFFSET, buf+size);
>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>> OD_RANGE,
>>>> buf+size);
>>>>                   size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK,
>>>> buf+size);
>>>>
>>>>
>>> [Yu, Lang]
>>> Yes. So it is fine we just fix the caller amdgpu_get_pp_od_clk_voltage like
>> following:
>>>
>>> static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>> 		struct device_attribute *attr,
>>> 		char *buf)
>>> {
>>> 	struct drm_device *ddev = dev_get_drvdata(dev);
>>> 	struct amdgpu_device *adev = drm_to_adev(ddev);
>>> 	ssize_t size, offset;
>>> 	int ret, i;
>>> 	char temp_buf[512];
>>> 	char clock_type[] = {OD_SCLK, OD_MCLK, OD_VDDC_CURVE,
>>> 	                     OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};
>>>
>>> 	if (amdgpu_in_reset(adev))
>>> 		return -EPERM;
>>> 	if (adev->in_suspend && !adev->in_runpm)
>>> 		return -EPERM;
>>>
>>> 	ret = pm_runtime_get_sync(ddev->dev);
>>> 	if (ret < 0) {
>>> 		pm_runtime_put_autosuspend(ddev->dev);
>>> 		return ret;
>>> 	}
>>>
>>> 	offset = 0;
>>>
>>> 	if (adev->powerplay.pp_funcs->print_clock_levels) {
>>> 		for (i = 0; i < ARRAY_SIZE(clock_type); i++) {
>>> 			size = amdgpu_dpm_print_clock_levels(adev,
>> clock_type[i], buf);
>>> 			if (offset + size > PAGE_SIZE)
>>> 				break;
>>> 			memcpy(temp_buf + offset, buf, size);
>>> 			offset += size;
>>> 		}
>>> 		memcpy(buf, temp_buf, offset);
>>> 		size = offset;
>>> 	} else {
>>> 		size = sysfs_emit(buf, "\n");
>>> 	}
>>> 	pm_runtime_mark_last_busy(ddev->dev);
>>> 	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> 	return size;
>>> }
>>>
>> Prefer to avoid any extra stack or heap usage for buffer. Maybe another arg to
>> pass offset along with buf?
>>
> [Yu, Lang]
> Actually, the buf address contains the offset(offset_in_page(buf)) .

Though it's not a problem based on codeflow, static analysis tools might 
complain.

> Or we just rollback to sprintf/snprintf.
> 

snprintf with (PAGE_SIZE-size) may be simpler. I think Darren took the 
effort to convert these, he may have some other ideas.

Thanks,
Lijo

> Regards,
> Lang
> 
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Lang
>>>
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  9 +++++++--
>>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 ++++-
>>>>>>     .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 ++++-
>>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 15
>>>>>> +++++++++------
>>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  3 +++
>>>>>>     .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 13
>>>>>> +++++++++----
>>>>>>     .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  7 +++++--
>>>>>>     7 files changed, 41 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>>> index e343cc218990..53185fe96d83 100644
>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>>> @@ -771,8 +771,13 @@ static int arcturus_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>         struct smu_11_0_dpm_context *dpm_context = NULL;
>>>>>>         uint32_t gen_speed, lane_width;
>>>>>> -    if (amdgpu_ras_intr_triggered())
>>>>>> -        return sysfs_emit(buf, "unavailable\n");
>>>>>> +    size = offset_in_page(buf);
>>>>>> +    buf = buf - size;
>>>>>> +
>>>>>> +    if (amdgpu_ras_intr_triggered()) {
>>>>>> +        size += sysfs_emit_at(buf, size, "unavailable\n");
>>>>>> +        return size;
>>>>>> +    }
>>>>>>         dpm_context = smu_dpm->dpm_context; diff --git
>>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>>> index 4c81989b8162..5490e8e66e14 100644
>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>>> @@ -1279,6 +1279,9 @@ static int navi10_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>         struct smu_11_0_overdrive_table *od_settings =
>>>>>> smu->od_settings;
>>>>>>         uint32_t min_value, max_value;
>>>>>> +    size = offset_in_page(buf);
>>>>>> +    buf = buf - size;
>>>>>> +
>>>>>>         switch (clk_type) {
>>>>>>         case SMU_GFXCLK:
>>>>>>         case SMU_SCLK:
>>>>>> @@ -1392,7 +1395,7 @@ static int navi10_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>         case SMU_OD_RANGE:
>>>>>>             if (!smu->od_enabled || !od_table || !od_settings)
>>>>>>                 break;
>>>>>> -        size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>>>>>> +        size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>>>>>             if (navi10_od_feature_is_supported(od_settings,
>>>>>> SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
>>>>>>                 navi10_od_setting_get_range(od_settings,
>>>>>> SMU_11_0_ODSETTING_GFXCLKFMIN,
>>>>>> diff --git
>>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>>> index 5e292c3f5050..817ad6de3854 100644
>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>>> @@ -1058,6 +1058,9 @@ static int
>>>>>> sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>>>>>         uint32_t min_value, max_value;
>>>>>>         uint32_t smu_version;
>>>>>> +    size = offset_in_page(buf);
>>>>>> +    buf = buf - size;
>>>>>> +
>>>>>>         switch (clk_type) {
>>>>>>         case SMU_GFXCLK:
>>>>>>         case SMU_SCLK:
>>>>>> @@ -1180,7 +1183,7 @@ static int
>>>>>> sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>>>>>             if (!smu->od_enabled || !od_table || !od_settings)
>>>>>>                 break;
>>>>>> -        size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>>>>>> +        size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>>>>>             if (sienna_cichlid_is_od_feature_supported(od_settings,
>>>>>> SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
>>>>>>                 sienna_cichlid_get_od_setting_range(od_settings,
>>>>>> SMU_11_0_7_ODSETTING_GFXCLKFMIN,
>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>>> index 3a3421452e57..c7842c69b570 100644
>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>>> @@ -592,7 +592,7 @@ static int
>>>>>> vangogh_print_legacy_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>         switch (clk_type) {
>>>>>>         case SMU_OD_SCLK:
>>>>>>             if (smu_dpm_ctx->dpm_level ==
>>>>>> AMD_DPM_FORCED_LEVEL_MANUAL) {
>>>>>> -            size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
>>>>>> +            size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>>>>>>                 size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>>>>>                 (smu->gfx_actual_hard_min_freq > 0) ?
>>>>>> smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
>>>>>>                 size += sysfs_emit_at(buf, size, "1: %10uMhz\n", @@
>>>>>> -601,7 +601,7 @@ static int vangogh_print_legacy_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>             break;
>>>>>>         case SMU_OD_CCLK:
>>>>>>             if (smu_dpm_ctx->dpm_level ==
>>>>>> AMD_DPM_FORCED_LEVEL_MANUAL) {
>>>>>> -            size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",
>>>>>> smu->cpu_core_id_select);
>>>>>> +            size += sysfs_emit_at(buf, size, "CCLK_RANGE in
>>>>>> Core%d:\n",  smu->cpu_core_id_select);
>>>>>>                 size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>>>>>                 (smu->cpu_actual_soft_min_freq > 0) ?
>>>>>> smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
>>>>>>                 size += sysfs_emit_at(buf, size, "1: %10uMhz\n", @@
>>>>>> -610,7 +610,7 @@ static int vangogh_print_legacy_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>             break;
>>>>>>         case SMU_OD_RANGE:
>>>>>>             if (smu_dpm_ctx->dpm_level ==
>>>>>> AMD_DPM_FORCED_LEVEL_MANUAL) {
>>>>>> -            size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>>>>>> +            size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>>>>>                 size += sysfs_emit_at(buf, size, "SCLK: %7uMhz
>>>>>> %10uMhz\n",
>>>>>>                     smu->gfx_default_hard_min_freq,
>>>>>> smu->gfx_default_soft_max_freq);
>>>>>>                 size += sysfs_emit_at(buf, size, "CCLK: %7uMhz
>>>>>> %10uMhz\n", @@ -682,6 +682,9 @@ static int
>>>>>> vangogh_print_clk_levels(struct smu_context *smu,
>>>>>>         uint32_t cur_value = 0, value = 0, count = 0;
>>>>>>         bool cur_value_match_level = false;
>>>>>> +    size = offset_in_page(buf);
>>>>>> +    buf = buf - size;
>>>>>> +
>>>>>>         memset(&metrics, 0, sizeof(metrics));
>>>>>>         ret = smu_cmn_get_metrics_table(smu, &metrics, false); @@
>>>>>> -691,7 +694,7 @@ static int vangogh_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>         switch (clk_type) {
>>>>>>         case SMU_OD_SCLK:
>>>>>>             if (smu_dpm_ctx->dpm_level ==
>>>>>> AMD_DPM_FORCED_LEVEL_MANUAL) {
>>>>>> -            size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
>>>>>> +            size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>>>>>>                 size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>>>>>                 (smu->gfx_actual_hard_min_freq > 0) ?
>>>>>> smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
>>>>>>                 size += sysfs_emit_at(buf, size, "1: %10uMhz\n", @@
>>>>>> -700,7 +703,7 @@ static int vangogh_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>             break;
>>>>>>         case SMU_OD_CCLK:
>>>>>>             if (smu_dpm_ctx->dpm_level ==
>>>>>> AMD_DPM_FORCED_LEVEL_MANUAL) {
>>>>>> -            size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",
>>>>>> smu->cpu_core_id_select);
>>>>>> +            size += sysfs_emit_at(buf, size, "CCLK_RANGE in
>>>>>> Core%d:\n",  smu->cpu_core_id_select);
>>>>>>                 size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>>>>>                 (smu->cpu_actual_soft_min_freq > 0) ?
>>>>>> smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
>>>>>>                 size += sysfs_emit_at(buf, size, "1: %10uMhz\n", @@
>>>>>> -709,7 +712,7 @@ static int vangogh_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>             break;
>>>>>>         case SMU_OD_RANGE:
>>>>>>             if (smu_dpm_ctx->dpm_level ==
>>>>>> AMD_DPM_FORCED_LEVEL_MANUAL) {
>>>>>> -            size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>>>>>> +            size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>>>>>                 size += sysfs_emit_at(buf, size, "SCLK: %7uMhz
>>>>>> %10uMhz\n",
>>>>>>                     smu->gfx_default_hard_min_freq,
>>>>>> smu->gfx_default_soft_max_freq);
>>>>>>                 size += sysfs_emit_at(buf, size, "CCLK: %7uMhz
>>>>>> %10uMhz\n", diff --git
>>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>>> index 5aa175e12a78..86e7978b6d63 100644
>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>>> @@ -491,6 +491,9 @@ static int renoir_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>         struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>>>>>>         bool cur_value_match_level = false;
>>>>>> +    size = offset_in_page(buf);
>>>>>> +    buf = buf - size;
>>>>>> +
>>>>>>         memset(&metrics, 0, sizeof(metrics));
>>>>>>         ret = smu_cmn_get_metrics_table(smu, &metrics, false); diff
>>>>>> --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>> index ab652028e003..6349f27e9efc 100644
>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>> @@ -733,15 +733,20 @@ static int aldebaran_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>         uint32_t freq_values[3] = {0};
>>>>>>         uint32_t min_clk, max_clk;
>>>>>> -    if (amdgpu_ras_intr_triggered())
>>>>>> -        return sysfs_emit(buf, "unavailable\n");
>>>>>> +    size = offset_in_page(buf);
>>>>>> +    buf = buf - size;
>>>>>> +
>>>>>> +    if (amdgpu_ras_intr_triggered()) {
>>>>>> +        size += sysfs_emit_at(buf, size, "unavailable\n");
>>>>>> +        return size;
>>>>>> +    }
>>>>>>         dpm_context = smu_dpm->dpm_context;
>>>>>>         switch (type) {
>>>>>>         case SMU_OD_SCLK:
>>>>>> -        size = sysfs_emit(buf, "%s:\n", "GFXCLK");
>>>>>> +        size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
>>>>>>             fallthrough;
>>>>>>         case SMU_SCLK:
>>>>>>             ret = aldebaran_get_current_clk_freq_by_table(smu,
>>>>>> SMU_GFXCLK, &now);
>>>>>> @@ -795,7 +800,7 @@ static int aldebaran_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>             break;
>>>>>>         case SMU_OD_MCLK:
>>>>>> -        size = sysfs_emit(buf, "%s:\n", "MCLK");
>>>>>> +        size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
>>>>>>             fallthrough;
>>>>>>         case SMU_MCLK:
>>>>>>             ret = aldebaran_get_current_clk_freq_by_table(smu,
>>>>>> SMU_UCLK, &now); diff --git
>>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>>> index 627ba2eec7fd..3b21d9143b96 100644
>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>>> @@ -1052,16 +1052,19 @@ static int
>>>>>> yellow_carp_print_clk_levels(struct
>>>>>> smu_context *smu,
>>>>>>         int i, size = 0, ret = 0;
>>>>>>         uint32_t cur_value = 0, value = 0, count = 0;
>>>>>> +    size = offset_in_page(buf);
>>>>>> +    buf = buf - size;
>>>>>> +
>>>>>>         switch (clk_type) {
>>>>>>         case SMU_OD_SCLK:
>>>>>> -        size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
>>>>>> +        size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>>>>>>             size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>>>>>             (smu->gfx_actual_hard_min_freq > 0) ?
>>>>>> smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
>>>>>>             size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
>>>>>>             (smu->gfx_actual_soft_max_freq > 0) ?
>>>>>> smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
>>>>>>             break;
>>>>>>         case SMU_OD_RANGE:
>>>>>> -        size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>>>>>> +        size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>>>>>             size += sysfs_emit_at(buf, size, "SCLK: %7uMhz
>>>>>> %10uMhz\n",
>>>>>>                             smu->gfx_default_hard_min_freq,
>>>>>> smu->gfx_default_soft_max_freq);
>>>>>>             break;
>>>>>
