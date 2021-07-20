Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C75C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 14:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3688C613BB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 14:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3688C613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D226E416;
	Tue, 20 Jul 2021 14:50:13 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A726E416
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 14:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6kKel0UwtwgS65btS1diTvjetMMy+kKeXE4SCEq1q68MwdpEHi6HwRMC859liLyi1LnHQeQAiR+H+JWBIB7OKOAmWhO6mzKcWOYQien3jNzsM7t8QfZ6QzkMi4T+0JETjcqGvdrMNymOqijnckvE9mZNzP5LhKO1mE6tQ66rIMYSI4iOsczOC/XU8ofo7hgw+AWJL9/4svEGQ4+wfH1Qmo5GMGs1AamjgagFhFqe729IZxZydjZAntVIWSCRdIt1IQEzgmmSM6K9/rejmpL6BajvhLOFAGxCPAy52E9ivz7CvXPLrKChP9PrCItUD2QNMSfRIlRW5AmgpRHrv8l/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUPaXGmeCAH2DuxvyTa0+j1Bb6jwxEvOSD7VCGpooik=;
 b=afDU9/490dqWAhlO98EsuVDbdnneaoyM4c/X+ExosOQ+FdhNNNdttDHEM6rZe+0cvqfwq/DT07qak0Ls7TzrRNeHfCMQOoErc0O4slOI7h6V3RWEl9yoHA0WRPIo9o5nJ2R4ox9g+rmcBripc3pFKf/VmmIv9maPqv0fL4cs5AJGuj80Eq3GdpCAc+FbTwfTV+U0QZYVMwVkCsj9ypKVIopTuUVM0vzuJhatQWtSisqZye9HuVlHFCE2zWDZaL0ar9OjO43dgueJT9VauLW5BGzLPO24YmrsK1DrmOZOSBDmdYoNwZsMdojr2kpK4g/nSj4uiMZiRb10Stxzv1yx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUPaXGmeCAH2DuxvyTa0+j1Bb6jwxEvOSD7VCGpooik=;
 b=VXAMdH9ViThpOoFncRxYz8j9dayiuBOtmh1HZPZ62JOdw7f9DvbZJRdObk2rnFOxIx9TuA3QJMt33gk9kn8KFlmdq1qig8GpvpRJ1PUjpRBYjDFKdurhOq5FMOhy203WbikLrv0zD+obNgu0QSWIwU9mt/jDnkMIkqC53xRx1MI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Tue, 20 Jul 2021 14:50:10 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::c9f3:45c7:6a1a:f036]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::c9f3:45c7:6a1a:f036%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 14:50:10 +0000
Subject: Re: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20210713103054.4161-1-PengJu.Zhou@amd.com>
 <CADnq5_OOhNpLE1uibK_L09epxyzymDxi4aAZzdWTqq6tt-wbVg@mail.gmail.com>
 <BL1PR12MB52698D14831EB471F690696E84139@BL1PR12MB5269.namprd12.prod.outlook.com>
 <DM8PR12MB547842919141D197309734C9F8119@DM8PR12MB5478.namprd12.prod.outlook.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <236f446d-e815-b3c9-d4c8-06aeb10aac14@amd.com>
Date: Tue, 20 Jul 2021 10:50:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM8PR12MB547842919141D197309734C9F8119@DM8PR12MB5478.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: MN2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::19) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.4.104] (165.204.84.11) by
 MN2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:208:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Tue, 20 Jul 2021 14:50:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbcb2b22-57e3-400b-b0fb-08d94b8dac5f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51819C1FC86B5723401416B0E5E29@DM4PR12MB5181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9VN+2IRJEo5WE+4S6HhR7TbQM0ULlSOhHCvN3BY1SKdxYOGOrXeVAmCjdcxAg2y6it/wRdulgNIWqwe/e+DW3X3WUQHUiAtC6wfn/D03Gxya72SVkV9SsjQ9eQVSSjH3PCKZYhOhyxR5ZDQogDaNYd5RBKh/7ebw+d2OJykEOkJfXTLLfHF0JFbw0u5s5//bLoYLRV2i3f4QDS4MHDJfVojnFsL+/7pX3UD+XCYnIeZbuK8m/7iEPYIOq1LoKluSETQnAW46/JRkHtt0j6q+HZ4hdexLDO9bS3IHAh9myrKpW4HxhQMt+p326sgll/q0pQkBGqxNtsTM6wSIZZuUYUk8Ijid382KSlyKR0xG2txbkP7dBM9peIA5JVTOdp1E+3DYNhyLeNg359X23NKKOb0K9EJBzJZw6dQVl5rZxer237Y7vHKmJxCfW4iTkcGrjlS8rc6Lm6FGfsgs5SZdb06+RdiLgG1V1MKjafTQLl53UZpRuodP3xtZhasMW7/Qdmii/qFGNMS1pxN8Udsr60TLhIMQts/kQfoyF/FWPn0K44X78WvasN8jL5HEmVmAsaBk1VbcIS5JA1LlZepuCo4/LvbH//q4LI/i5Ystv97mFK3S+E2D9YXbSNxof3pfk6Lg3Wmaw68k59CyLAyjLXZvYEr0JRxoTPVrZ5fjxoYPVAJbHH3nsYyl9/064idDNTB5/lM1yPaOD1XuZ+rO9SzTPmHoZqEHQf0BUcAleC71+1htILG1cpTb7Z+D0HvmMNPeHactFeEpgEJ0LaEPrEgKBGMtk8QX5sgaeCIGAl2Vhjrf1d5FMKEetxWBoTV795KhgR31HX1dMiMNSi4r6h4Foj2aYiGXa1VS15N3Jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(84040400004)(4326008)(2906002)(966005)(44832011)(956004)(2616005)(38100700002)(316002)(16576012)(31696002)(86362001)(186003)(110136005)(8936002)(66476007)(66556008)(66946007)(83380400001)(36756003)(26005)(6486002)(8676002)(45080400002)(5660300002)(478600001)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3Q4YXBnOUsrOEdCbHhDOEp3SDRCOXdoZTNBVkxzOFYrQSs2ZVNaSWRDME1U?=
 =?utf-8?B?SmJ0aE5vYWVYREl1WWdyTXBPYkJiTkdtaGFHQkJzc29kVXE3eHd3dUVwcHF1?=
 =?utf-8?B?MmZQRXpjK2Y3RGExbWoveGpjc1RtRW1EcHZnKzE5RWU1TEVWZjRtVURFd1Fs?=
 =?utf-8?B?WXMwaWlUM1Y5ZjBrQTlsaDFlTmgvRWNDUWYwNWZiS0k0Z3d4Yk4rcm42VlpN?=
 =?utf-8?B?bUtOb1o1MSt4ZHRTQ3dEVzNpMjlpTHpUSmpHbXB4ZjYzMlNUNUFxR1pHN2ZO?=
 =?utf-8?B?RHc5azBXMEdMMTVtRW5YV3NqTGt6TjJGbTVYK25XYW9PZXRMSGd3N2E4YSsr?=
 =?utf-8?B?QTdBeWtTeG5LZkU3TXdvbWFxMFRQYjBEekVONExwbm1Bd2MzbG5ZMnFjSW5I?=
 =?utf-8?B?enNQU2FMWS9ONkx1VlBEZzFtbC9qTmdoZW9FYWowSzZFeTRGYmsvSTdPb1hw?=
 =?utf-8?B?THNYSVNuTGhEc0h2SVNubGJ4YndYb3cyMnYwSm5LMHVudmszWEppL1Q0VTdw?=
 =?utf-8?B?VzhaZUI0YWpKU1BaU1BwNlMvSlBVSDg2Z1YrZWY4T3J6M09pWEhxYkhPZ2Rq?=
 =?utf-8?B?bnB5a25IWU9ybFExWmd3cE9SZ3A1eXdSREFuYTFpb084TCtuVmNiOXRreFY3?=
 =?utf-8?B?TWFUOE80MHQzTTZaSCtSdHpKUThUeUc0cFNQOUZSTUlWTWFjZlRRUHlIUjJu?=
 =?utf-8?B?SEJwTDBLU2xuYW1Udi9uTkRoYlJJNVBScEE5dGM4NmlsY1BGQ3poblV5Ym1t?=
 =?utf-8?B?bC9IQUQzU1VtdHNqVjhBOFhGRVFGcHU2d1RaMjdpU1hybDhXM2xkRDAxUUVi?=
 =?utf-8?B?ajU5WnFIYVNaakxRaThYTjBkMmNIOXlzbUkxYUZPQ3VVZnFOcHRZVHhCSUxV?=
 =?utf-8?B?Y01lVWtxem1vb1R3b3pkenJ5emFxaFEycFFFR2pYak1qMWxYRWdhQ09NeEhB?=
 =?utf-8?B?QWVHYXBNYk1IUEF1R25pRDJqenZUWWpldHlzWFdYeC9mYlBCa0JFT2hpaEdt?=
 =?utf-8?B?TUpjalMvRGxWMXRaWStVZHliWE5BcUd3RHZ1L1lIMk5YRU5VZXJrT2ZxM3VS?=
 =?utf-8?B?N1YreE1aU0d1OGhoVlFIL1NiWWMrSnBnUzkwUTdQVzhsVy9oZ1g5R25ORWRo?=
 =?utf-8?B?SXoxbVFpR25EYzBWcUphUUxnbmxMa3NuVnBBS2phNW9aL2pmZlErOGxBNmpU?=
 =?utf-8?B?dXR1MTROL0ZtVFA3WFBrSG5QRDZsT2Ivamxkc2hqWjNEajhST0tKOUU0U2dv?=
 =?utf-8?B?V2R2UVJyQzhRMDVWYndpRTk3YWtsL2R1Wm4weXd0RVkrZE5IeVhnQi9vdlIv?=
 =?utf-8?B?S1EyZVJmOW1FNVpRUWhCMlVmSVcxVVV3OEJyUjE5U1NNejhDK0xRVWcxd2hp?=
 =?utf-8?B?RG1JOS8xQkM0L0hyYVBDT2U1TWtMWjJvZldycjh6SjJiazVLbHJmcUdpWkFY?=
 =?utf-8?B?b01sMytvczY2TStiZWZneGVDTVgyS25UdjhDRTFkSng0UlpLZkZYYnE2eWJD?=
 =?utf-8?B?NUtNZXBJbndXYmxCMkFjWmVVVGNoUEFIRTErVHd5ZDdmS1FMT2VRM1Fpa3dV?=
 =?utf-8?B?M2J1R1dmRklMUVpwdUlVcDlqZmc4QTJyWXdMdUJrWjlXTThHRGk4Q3NOdVFV?=
 =?utf-8?B?K0lWOUlwTDdYZ2JEYWdpenZ0Q3RQWjNndXQrOVlCWTlwOWxtV0RJR0RBSnc1?=
 =?utf-8?B?ME0xMmljWHZPaFFoemhQTnpPaW9VZVlEeGVZQ2dQRVRMUUJCNjhyRHpzS1Zn?=
 =?utf-8?Q?QX2KE0Z8RbXi2cPik1gpC8MPUZo0B4UGM66Fh2E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcb2b22-57e3-400b-b0fb-08d94b8dac5f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:50:10.6439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT/ZHBe4UYtpeUmibtSFmyiTLQO2PlJtNEmWqe9Fr8d76o6jcRlSsefYq5qXRBad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
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

It looks good to me for the non-sriov part.

Regards,

Leo


On 2021-07-15 10:14 p.m., Zhou, Peng Ju wrote:
> [AMD Official Use Only]
>
> Hi @Liu, Leo
>
> Can you help to review this patch?
> Monk and Alex have reviewed it.
>
>
> ----------------------------------------------------------------------
> BW
> Pengju Zhou
>
>
>
>> -----Original Message-----
>> From: Liu, Monk <Monk.Liu@amd.com>
>> Sent: Thursday, July 15, 2021 7:54 AM
>> To: Alex Deucher <alexdeucher@gmail.com>; Zhou, Peng Ju
>> <PengJu.Zhou@amd.com>; Liu, Leo <Leo.Liu@amd.com>
>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>> Subject: RE: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
>>
>> [AMD Official Use Only]
>>
>> Reviewed-by: Monk Liu <monk.liu@amd.com>
>>
>> You might need @Liu, Leo's review as well
>>
>> Thanks
>>
>> ------------------------------------------
>> Monk Liu | Cloud-GPU Core team
>> ------------------------------------------
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
>> Deucher
>> Sent: Wednesday, July 14, 2021 10:49 PM
>> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>
>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>> Subject: Re: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
>>
>> On Tue, Jul 13, 2021 at 6:31 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>>> The previous logic is recording the amount of valid vcn instances to
>>> use them on SRIOV, it is a hard task due to the vcn accessment is
>>> based on the index of the vcn instance.
>>>
>>> Check if the vcn instance enabled before do instance init.
>>>
>>> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 33
>>> ++++++++++++++++-----------
>>>   1 file changed, 20 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> index c3580de3ea9c..d11fea2c9d90 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> @@ -88,9 +88,7 @@ static int vcn_v3_0_early_init(void *handle)
>>>          int i;
>>>
>>>          if (amdgpu_sriov_vf(adev)) {
>>> -               for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
>>> -                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
>>> -                               adev->vcn.num_vcn_inst++;
>>> +               adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
>>>                  adev->vcn.harvest_config = 0;
>>>                  adev->vcn.num_enc_rings = 1;
>>>
>>> @@ -151,8 +149,7 @@ static int vcn_v3_0_sw_init(void *handle)
>>>                  adev->firmware.fw_size +=
>>>                          ALIGN(le32_to_cpu(hdr->ucode_size_bytes),
>>> PAGE_SIZE);
>>>
>>> -               if ((adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID)
>> ||
>>> -                   (amdgpu_sriov_vf(adev) && adev->asic_type ==
>> CHIP_SIENNA_CICHLID)) {
>>> +               if (adev->vcn.num_vcn_inst ==
>>> + VCN_INSTANCES_SIENNA_CICHLID) {
>>>                          adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id =
>> AMDGPU_UCODE_ID_VCN1;
>>>                          adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev-
>>> vcn.fw;
>>>                          adev->firmware.fw_size += @@ -322,18 +319,28
>>> @@ static int vcn_v3_0_hw_init(void *handle)
>>>                                  continue;
>>>
>>>                          ring = &adev->vcn.inst[i].ring_dec;
>>> -                       ring->wptr = 0;
>>> -                       ring->wptr_old = 0;
>>> -                       vcn_v3_0_dec_ring_set_wptr(ring);
>>> -                       ring->sched.ready = true;
>>> -
>>> -                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>>> -                               ring = &adev->vcn.inst[i].ring_enc[j];
>>> +                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
>> {
>>> +                               ring->sched.ready = false;
>>> +                               dev_info(adev->dev, "ring %s is disabled by hypervisor\n",
>> ring->name);
>>> +                       } else {
>>>                                  ring->wptr = 0;
>>>                                  ring->wptr_old = 0;
>>> -                               vcn_v3_0_enc_ring_set_wptr(ring);
>>> +                               vcn_v3_0_dec_ring_set_wptr(ring);
>>>                                  ring->sched.ready = true;
>>>                          }
>>> +
>>> +                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>>> +                               ring = &adev->vcn.inst[i].ring_enc[j];
>>> +                               if (amdgpu_vcn_is_disabled_vcn(adev,
>> VCN_ENCODE_RING, i)) {
>>> +                                       ring->sched.ready = false;
>>> +                                       dev_info(adev->dev, "ring %s is disabled by
>> hypervisor\n", ring->name);
>>> +                               } else {
>>> +                                       ring->wptr = 0;
>>> +                                       ring->wptr_old = 0;
>>> +                                       vcn_v3_0_enc_ring_set_wptr(ring);
>>> +                                       ring->sched.ready = true;
>>> +                               }
>>> +                       }
>>>                  }
>>>          } else {
>>>                  for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>> --
>>> 2.17.1
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7Cmo
>> nk.liu%40amd.com%7Ceee0db55446b43f11a5d08d946d69bda%7C3dd8961fe4
>> 884e60
>> 8e11a82d994e183d%7C0%7C0%7C637618709836027968%7CUnknown%7CTW
>> FpbGZsb3d8
>> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
>> %7C1
>> 000&amp;sdata=0lw4us%2FTz66cgN6I0kQSwQDQzYRKfa2VuSBemqDMhcs%3D
>> &amp;res
>>> erved=0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
>> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7Ceee0db55446b43f11a5
>> d08d946d69bda%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
>> 618709836027968%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
>> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=0lw4
>> us%2FTz66cgN6I0kQSwQDQzYRKfa2VuSBemqDMhcs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
