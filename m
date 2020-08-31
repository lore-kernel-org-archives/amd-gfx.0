Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA67C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD61C20866
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N1vwfTW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD61C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9247389CD3;
	Mon, 31 Aug 2020 21:51:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145B389C85
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 21:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+hVBr0hx3+Eq75tvJC2vu6eqvQ5Uhxu+tbxeRaQ+029d7dasbCnxzbKAmfnPzwbokWzwjqx+4Gll8F4fWKgM+4CswN55RSKKeBoJ7d3Tg8rNCo5vO6PNK/59nkYbEEGXhX1mtqSePYdKeTawB6NZDNEvxhfkKyhtLmumTf1eRpZHbETp9rQ8AtwmEFpDrx21CBP954qbVlz1HgkfpVg0nx0f/EMOrNZJmSXZptiBS5PKLW1Z85+BwUwoT+FEJNAtFEYA+sm3452Z6KyS0EaJlyVfRwPwfeo8DsBnTSG6Y1kxrbOnTI2oC8a5619wd5TohvMehSQXcS43oxh25zlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5sCDX4+lhMs35nCdgmD6CKmkd/Qxd0cca30fnCbMdw=;
 b=bQaY4QNLL5XRQ0vrpbSkQv+lDiENLkTHzYShaOUYqgEgdcrGislW4pQkYlQt0SKojQL6iPTInEO4k5ZPIxVEfB+G3VfoDxOitMrZ9Z0GabJujbUJH3/vw6VNlOf5hOXvUcQN32hTp8/mzmebyt6rZAeQeAI/W42GM9kc5ajEMud/Vd4tHKjUExotkzWmb62T/MeWutPAHDjikL+qUR7TZrxOMRRnI1xKugRiTofl/y+yWEtZd3/9MotyE3PdZCSb1xU+I4d+L5ZOYBlS6PE1YDRBirVFxLGshfxnMNLgCFgH3HDKTFo27VM+LcXPvIPtjeyENUP5hEY45ScAnmRf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5sCDX4+lhMs35nCdgmD6CKmkd/Qxd0cca30fnCbMdw=;
 b=N1vwfTW7hCo0b0by99J3dDESjtKcgDiMW8f+UA9aq7GLO6KYrVTuLeE4PXdMa1d7XuLRKDyNAJBd0j6DMQFKIwC2BtO1lU9yggcob4wFnOtjzBvGUa1F4Q/uFXRl3w47HL8R1wtOZtHIq7TKxYDdWs1H5B1zohtehmMxwlq4ZrI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Mon, 31 Aug 2020 21:50:56 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee%7]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 21:50:55 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
To: Alex Deucher <alexdeucher@gmail.com>, Nirmoy <nirmodas@amd.com>
References: <20200831104553.10207-1-nirmoy.das@amd.com>
 <CADnq5_P=LUjg4GubYdFFSBM+aXpkxOJ6yoD_2iNLNMSe_Vyzrg@mail.gmail.com>
 <0162c712-a0cd-78ee-0e87-6a612a1e81cb@amd.com>
 <CADnq5_MMKrR=TMF=-YcUM60eJO=osVB9N=H+hM93Pak=VXLBvA@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <00075962-70ba-a7b6-82d4-448b97ae5c99@amd.com>
Date: Mon, 31 Aug 2020 17:50:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_MMKrR=TMF=-YcUM60eJO=osVB9N=H+hM93Pak=VXLBvA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 21:50:54 +0000
X-Originating-IP: [2607:fea8:a3c0:203:ddeb:dd7b:1414:d938]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6327e131-f36a-48dc-642d-08d84df7f00d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1625:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB162523A04FE6017C67757F7BE5510@DM5PR12MB1625.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGSVtvPCflwI4jVOVE54XmilTKKW8DhXGvspwXoL9dWOt3T5CM/1G1/ZhLeye1XLJWv3ZKlwhjvpKv1P3XgT2SggDH+8fu+pRlri3IQsjnv340+0HqX5C0Q4kpsb2xMJqbl/b9MPKze5sNuUQ/KJFS08Ma+eDDNYPM3ahl4VqZiW2vqSf8e0gpxRPZlCLhhy/GBvJnJNv3n/SdUZ6Z2mEJkbyz+mU8otPSi+C0Z419d0/cmTqMeMcQNC3UlAML9zvGbt2uKBH33llmyXNjEzhHH7EFIQBPq+lL9q6srN37yNdTOrgS+mD14bFwz8RgoMLgIhWCIKtDseYxwxicG6M4VNIhDaiIe2X5N+uTQnwTXPCsUYvGmwtlPtyVaGcZuIZetX8tD8uE0xwEOoUqlRMpco567E+gfl89kW0u5wLGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(2616005)(8936002)(66556008)(8676002)(6666004)(186003)(54906003)(66476007)(44832011)(966005)(31696002)(4326008)(956004)(16576012)(316002)(478600001)(110136005)(36756003)(66946007)(5660300002)(52116002)(2906002)(86362001)(53546011)(83380400001)(6636002)(45080400002)(31686004)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: G4eUhh5fiStl1An+1jyMkFYKYC8OrkV72FsZr+B9ARCgeCKnDAt3Rduf31qteaoNLJcQ3GwimsIrE1m2IdwWllG2p8XO/gffHTd97RyFPMX5VojIEqBBT0Dn9Rq5jvusSVx1pCLpiymjW+dSkpTFGfSlJSf3hOLny1ynkJC9dElLsivkd5oWsXqlJnky+arKlxRXR3EdrDh4mklW9saRhScJQZe30//FgyCmDX1r1pzPgi1qLPltAx5Zwz3ua357nLp4hmVvl8Y1YCU5oDmDpkx4LDv//XWuk1C2/TQkex/p75trc7jtqrGH7sxFmawMaXIa4b+54w79SFQ+gkqi3FwjVr3hWOPCVe0uHJpDg4n1QWRD4bHnvxyaB9MgVO9ibd1hH5zL4Uq/JYxx+U2kYsh+C/6dQZGl6m1dA1Scw+8IDmVB+YjM7AC4EbQzxaQ6LBWVonWxoRjpgc/meAz1F7yyoFb1cXUJndjsgpwfKXkPB1PTMlNfV15EbykoD23d3A4B5lC83jH/wqlU0AGzNjl+Im+Diw6323QMffZCJ7wQbNIdiER2zhRflgt6afFHOIpu6j5sbiz+eONZyKrib+jsSHOEjvhVYocPMbb/niPd6K4xPaizW0Zih+fhFC5GqT6jjEx4au6I//315cPiRcLuCpr68pXmTGcKJx6/Q+jdXaVVMLLO/HLU2eeh+g0w0ljdxLIUzGJk2aEMIv2e4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6327e131-f36a-48dc-642d-08d84df7f00d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 21:50:55.5244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyjbc1+GSbyRkTlIa4aUYH4XPODxP5WWG1ylvBcq19c/h8IetyAqfO5H/N/VrfBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, tiancyin <Tianci.Yin@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-08-31 1:39 p.m., Alex Deucher wrote:
> On Mon, Aug 31, 2020 at 10:55 AM Nirmoy <nirmodas@amd.com> wrote:
>> Hi Alex,
>>
>> On 8/31/20 4:17 PM, Alex Deucher wrote:
>>> On Mon, Aug 31, 2020 at 6:41 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>>>> UVD dependent jobs should run on the same udv instance.
>>>> This patch disables gpu scheduler's load balancer for
>>>> a context which binds jobs from same the context to a udv
>>>> instance.
>>> typos: udv -> uvd
>>> With that fixed:
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> Does VCE need a similar fix?  What about UVD_ENC?
>>
>> I am not sure, can you please confirm this.
> @Leo Liu can you confirm?

Vega20 have 2 UVDs and 1 VCE, so UVD_ENC(AMDGPU_HW_IP_UVD_ENC) should 
need the same fix.

Regards,

Leo



>
> Alex
>
>>
>> Nirmoy
>>
>>
>>
>>> Alex
>>>
>>>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> index 59032c26fc82..7cd398d25498 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> @@ -114,7 +114,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>>>           scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>>>>           num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>>>
>>>> -       if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
>>>> +       if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
>>>> +           hw_ip == AMDGPU_HW_IP_VCN_DEC ||
>>>> +           hw_ip == AMDGPU_HW_IP_UVD) {
>>>>                   sched = drm_sched_pick_best(scheds, num_scheds);
>>>>                   scheds = &sched;
>>>>                   num_scheds = 1;
>>>> --
>>>> 2.28.0
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Caaf07c8faa4d46f0b35f08d84dd4e875%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637344924116323889&amp;sdata=kvny71irAythb60XTzLHokUD7ZifHAKkTND8zSNs3T0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
