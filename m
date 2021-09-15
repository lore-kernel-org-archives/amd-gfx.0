Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	HTTPS_HTTP_MISMATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 09:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F187C61214
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 09:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F187C61214
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654156E8F2;
	Wed, 15 Sep 2021 09:56:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8916E8F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 09:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa4rNf4bANJnsOi0nu3sXsjtqXHSbC1xhVU2DbBCPAID31Yj0dvX5xooECXSRqTX0wAImjozfamOkub1S5CQKXK7t0XBM8ECh03hA477/O4LcI1q3ismZxjO0Oz/r94YaFMK6JXRXW7+IxPsYX0FgSU5Oe6oLRMOt8k/fKj8WskYSmpOobg9WjUpJsRmZ1nj8C5Fv1PK+AxJBtd7kXXt+ojgENCd/27gVw94J1ooNh0jK25ieU7PoS3NlCaPOakNksX8IC/pmPbdBllnDtFkilkHEq3spL3BNsYFBQDVIId3uv4cuI5puA5sfaxbVkRhG0cyrjtZ+aHWrbdUnUQE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=j1JPN+8Ey+Us4aOyHPDDLYm3xIW1Kg9dO+lu2ky7dM8=;
 b=RpPAAjNunuAmecu5QGM/AyrK6NPMth1p9boarfP8On1vgmj4j5ewVV3DitsgGK/Z3X/YKoNsyNXtD9iNQ3fNtGV92xujX9iPOXocJYjSkIGNwIQBfeUREevYTix4br0FUCNunfC1K6KtYHD2o6EzLL7Z/DJ6hQhUK3cH0I8CBIKjnent+EQqscn8jrUIWUDD3jTKxLPqnDO8E1+Uc1SVgfcAI735uRjU1tzHGFS27uM4UMjC6vh4Z3Ut+Sh61fCA63lhMurWukHNJ0R9RoavmUJDGRpbiqNAaailX7aCWVuutQB3iSxqVV0qNWrJ/XNaxe7XTHs2dt88WcwYE5rm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1JPN+8Ey+Us4aOyHPDDLYm3xIW1Kg9dO+lu2ky7dM8=;
 b=dnb0Z9vwauwIsOUhgQqzFDp8FA134Gmm8OKkEo4TWAGWayg4kp0L4kDQ6d0FHN3iuNT1iwDj358/bPpXJjlZygbJn6xBETCpmCoQndgl438BlR14puGd8efMf1OseChcHH+3ap3R16JMPz1zLIQUgjST1von6WfORib90pj02o0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 09:55:55 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 09:55:55 +0000
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
 <CABXGCsOPLH2DkZ09PDXSxStin6JJb_m5bJuQWmXooBLaSJ2Ezg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dcbb87cc-c95d-ae58-d601-413a6277a7f8@amd.com>
Date: Wed, 15 Sep 2021 11:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CABXGCsOPLH2DkZ09PDXSxStin6JJb_m5bJuQWmXooBLaSJ2Ezg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------EF33C0CDB06F06965B4EF6C7"
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:d03d:8939:3840:1f95]
 (2a02:908:1252:fb60:d03d:8939:3840:1f95) by
 FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.9 via Frontend Transport; Wed, 15 Sep 2021 09:55:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f918a1ad-e8c0-4ab3-deba-08d9782f02a7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4112:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4112478DB31482BF57A8095183DB9@MN2PR12MB4112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mpXX+Pmf9HEchnDSPEqFawHGHFNMhZ1bCGHIVODRxtpXE20RRzOAW8efXEWimNO8Kud/7lPJt3TNsdIWMUvH4zF9l65JlMgnlx563Y9EmVgwfWuKVJK2loXV9e9bYdidHJmtyREwkqy7yzlmEnF3bfrSnwRpxnQCt2Mu/eM/GhuOIJnsNau1bRukbSHJf85Cp0Bqq58fstXIEsrGlWfBzKcX1QjmWa0QFs4vYzWaRyDvaE2TilvuulrzT2rezp3/r/O6fjhOFFHlzl/J6MsxyKJSUOgRk4WnkUIYPDfqT//dvYxkfmWlSgFD9o/MCPa15NqJJVdTotmpOYPwn3yeFL2d1dNvL74BORzFPNOwksDYU7Uj7mNIwgkMJNi2oPDYoRE3eI/hq4GGjp1ba7BqV7BzG4Oe6cqsiAMScFNQ/PAtoBsqLn71hqjNaLF41DYmApxMKYmjsbgoyza3p5e67gUWBwVI9dBLub+HV9VKgtQVqotlySrHix9CjVBdoNtGhQE5Xaf3YQPfn8QXUSzk0jbi+uqcPbCw7MLFDh8VYm7tfGAWBxujc4Qoa0MHR6i8ssQvg187maXkaObYAlcmmDSmURuPdp8FWKy4lIcaCSJbgFbvW+s09UxTlWnTrNfKO7r/WEjMtvRaQK97sKulGcQnIpLxMCbld/egFruB5c9k7qseEoxuXLwrXUE44V5K084IJQERAnEQgb/OkxrBIbIBcUDrq0YED4U/cNfpjwOu3wjyMhpvfJHCYx0yGLON2sf2ZbBpQXyMxPr9RAABAIHLL+EeLEWkJTZ88OKwWpxA0EMhBKqcUh/luwZstLR/Qzwxl1yCx2UhlYVpHxv4n0w02Ycy+HUPxgBlp33o/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(66946007)(478600001)(6486002)(166002)(83380400001)(8936002)(8676002)(110136005)(66556008)(45080400002)(2616005)(4326008)(66476007)(966005)(33964004)(316002)(54906003)(86362001)(38100700002)(186003)(6666004)(36756003)(31696002)(31686004)(5660300002)(2906002)(10126625002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1dkcGlLZytwcnF1Yk5DM2R3aHBNQ09SbDcrcWVzM0hmY1BRUDNtdjUyS3Nh?=
 =?utf-8?B?N0NwUFp0VURpR2crYlRiWERnUFRMUk9MVkZKSXFTMnBvRy9ERFQ4N0lUa1B3?=
 =?utf-8?B?RVcvK1FCVUNuRVFyZjEzRVJoQnlPK2F2T1RnejBiUjZKeWg1R3gyZ3gyL3Zn?=
 =?utf-8?B?SXM0UERtNFBCbS91SjBPekNYZnNlbC8rcmpzdGM4ejQxZmQzbjFpT2Via1J3?=
 =?utf-8?B?NjUzSWNkTTI3dEdIUCtlanFBNndiNW9KMC9WdGh3Z1JZcUlGc2JQempHN2lM?=
 =?utf-8?B?V2o5MncxM1NPbHBhbVFGcmJybU4xMlVQMjhPT05BeHBGU2hqd0F4clh1djZJ?=
 =?utf-8?B?WTVyRTdSNldTYnEvdUNUSHZ5eEphaDZ1c3pVNWhVbDRnaldEM0phU2dxR1BR?=
 =?utf-8?B?Y3Ywb3NqeVM5dllGS2k4ZUdPZkpUTFk5UFlFOGo1cHNHRlphaENobHh4bHZu?=
 =?utf-8?B?aFlxRHJKRThPblp2STRvNEZaVy9udUJjMHZWYkdsMm5RZUYxeldkYklwbWZz?=
 =?utf-8?B?SGlncXRUd21RanM1eXpsNlg4elBXUEVzN1ZwV1l6dHVRTzNGR0VmMGJXbTc1?=
 =?utf-8?B?YjZsM0JXNkN2U2xDeWs4Q3J1VXlKNGt6cWtLSWJQZjJ2V0tGZi93R0F1bDE4?=
 =?utf-8?B?TjJ6eHJLbUliaHhsbktFOWtIcUhoL2JBb1ZyOWhMelJSVmNkaVlBTDkrZ1hC?=
 =?utf-8?B?eGM2VlBybGVoS21yRVFLYm1qQWF5Ym1URW5wZGlLWnVQWDVDd0tlM2U5Qncy?=
 =?utf-8?B?bG4xY3RTU2V5d2RPL0psU0h5K3ZlM2Nid0piRjB1Qk9GSVEzR3dmZzlXVGlt?=
 =?utf-8?B?WUo1S29uUU1NdnUrS3ZreTBkb21TbkMyU2tINE5WeXZLbHN0aFdrREpCT0RP?=
 =?utf-8?B?QnB6Q09VQVlWQ3BOUGtBQmJzajdzSmlERjYvNWlSd2QrRkovYU83VXQzQXZm?=
 =?utf-8?B?SWc1cVk0STF6R1lzSnp5MUc4enlVbHhHUmE4Ync2SEdQOTJtOTBKZnJzeUdo?=
 =?utf-8?B?Zm41VEo3VlBLOEtYZjg1V2M1UjZkWFZLNzZRQ0pqVStoOStFYTVIeFhLWWw5?=
 =?utf-8?B?V2MrZFdUR2VCK2FYKyt3eUJoVUtmTzFsVGJJakpmT2JxS1dWYTBVTjhvOWsy?=
 =?utf-8?B?c3N1bHR2TUhPTGtJd0Q5aXdxenBMemoxVm1sQTBMR1J1OFFQRnNjdDVjTHhF?=
 =?utf-8?B?M0VrTzRuSTBEaGFvcW1VMXd1cUs0Y0F0dUFSdWwxaCt5TXBaQ3Z3akdKR3hl?=
 =?utf-8?B?a0R0OGt3a3dNTEdQRDdmVHY4VEVZcmlkSEwveG9ac2R0T2poT09pemphSVlx?=
 =?utf-8?B?Y0x5dDZweVBhYm5tblpFY2U5L243Wm8zNHI3R1F5ZVVmWmRHYnRaa1JDUXNa?=
 =?utf-8?B?WWVDb05IcHZYZDdvUjFtaE96Y0hIM2U4SGtvc25FY0dCUnBPM3ZLZC9CQ0NY?=
 =?utf-8?B?RGhVbjlIcmRoRVRWanZLdzJsU0tkalFLQm9rUUovcCtkeXRsNjR6ejdDajlF?=
 =?utf-8?B?cDlvSERmZXBPYlViV3VPNmx1QUEyR2Vxbkh0bmhvbjVWOE9VRlplcW1NVUlB?=
 =?utf-8?B?R3JYdE5CYTJuS210U3NZb1d0SkthLzNsaWJBUEpxZGZwajhqaUdXVGFJV0wy?=
 =?utf-8?B?K1lmYVFORldSeXBJaWxSK1dhRldCQjNRS20rdThTdGlSVDdwcmxJaXBZOTVO?=
 =?utf-8?B?UFVGSmFCYi9TMTlmenNrUDVMbkR3d2grRzZvRGt2ZkJUUW1Db2s5bEFnNGFG?=
 =?utf-8?B?TnZ0b1JRUzNyR3ZsWGVwRFQ5d3lWMVU5SnhHWnlKam01TXpLNy9LL29RMkpt?=
 =?utf-8?B?Q1dWSXh1WXZyYWljWTZITVRhVWJSNVJvL1lweTZIWUNWQXlqOW81MUZmaEV6?=
 =?utf-8?Q?2VmcUfKnYcShv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f918a1ad-e8c0-4ab3-deba-08d9782f02a7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 09:55:55.6345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FbOb7rnrw8uEP9PdmRy+A04q8NQeBL/W8ArHKqCoOFPUY4QyYcKe/fJdbfKJ5Y8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

--------------EF33C0CDB06F06965B4EF6C7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.09.21 um 20:19 schrieb Mikhail Gavrilov:
> On Wed, 14 Apr 2021 at 11:48, Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>
>     That is expected behavior, the application is just buggy and
>     causing a
>     page fault on the GPU.
>
>     The kernel should just not crash with a backtrace.
>
>     Regards,
>     Christian.
>
>
> If after it GPU hangs with the message 
> "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for 
> fences timed out!" is it also expected behavior?

Yes, absolutely. You should see GPU resets and recovery in the system 
log after that.

Regards,
Christian.

> Kernel log: https://pastebin.com/WkhATKXX 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FWkhATKXX&data=04%7C01%7Cchristian.koenig%40amd.com%7C83d3316107ce4c9fe42a08d977ac2ea3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637672405000225872%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&sdata=BSCdZefdxpQPBdKzrcII8e9LDR8nN%2BbMkswE%2FEkaXv8%3D&reserved=0>
>
>
> -- 
> Best Regards,
> Mike Gavrilov.


--------------EF33C0CDB06F06965B4EF6C7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 14.09.21 um 20:19 schrieb Mikhail Gavrilov:<br>
    <blockquote type="cite" cite="mid:CABXGCsOPLH2DkZ09PDXSxStin6JJb_m5bJuQWmXooBLaSJ2Ezg@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-family:verdana,sans-serif"><span style="font-family:Arial,Helvetica,sans-serif">On Wed, 14
              Apr 2021 at 11:48, Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
              wrote:</span><br>
          </div>
        </div>
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex"><br>
            That is <span class="gmail_default" style="font-family:verdana,sans-serif"></span>expected
            behavior, the application is just buggy and causing a <br>
            page fault on the <span class="gmail_default" style="font-family:verdana,sans-serif"></span>GPU.<br>
            <br>
            The kernel should just not crash with a backtrace.<br>
            <br>
            Regards,<br>
            Christian.<br>
          </blockquote>
        </div>
        <br clear="all">
        <div>
          <div class="gmail_default" style="font-family:verdana,sans-serif">If after it&nbsp;<span class="gmail_default"></span><span style="font-family:Arial,Helvetica,sans-serif">GPU hangs
              with the message &quot;</span><span style="font-family:Arial,Helvetica,sans-serif">[drm:amdgpu_dm_atomic_commit_tail
              [amdgpu]] *ERROR* Waiting for fences timed out!&quot; is it
              also&nbsp;</span><span class="gmail_default"></span><span style="font-family:Arial,Helvetica,sans-serif">expected
              behavior?</span></div>
        </div>
      </div>
    </blockquote>
    <br>
    Yes, absolutely. You should see GPU resets and recovery in the
    system log after that.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:CABXGCsOPLH2DkZ09PDXSxStin6JJb_m5bJuQWmXooBLaSJ2Ezg@mail.gmail.com">
      <div dir="ltr">
        <div>
          <div class="gmail_default" style="font-family:verdana,sans-serif">Kernel log: <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FWkhATKXX&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C83d3316107ce4c9fe42a08d977ac2ea3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637672405000225872%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=BSCdZefdxpQPBdKzrcII8e9LDR8nN%2BbMkswE%2FEkaXv8%3D&amp;reserved=0" originalsrc="https://pastebin.com/WkhATKXX" shash="byEtA2mSNqmxc/eIXmBwLPEBFaZGdliV7dBT2fsdkAYRnRv31M9fy5oNTfGKkYLJlErTxSSy6NjqGWuYkY4VvyyqakSuiIr+h+dAnzXr7TizY2sefLxORWOL7lEelWitLY/3Of03jiTlbUoqCzLJkvsna7K1kJ7U35ZzpoKXg3Y=" moz-do-not-send="true">https://pastebin.com/WkhATKXX</a><br>
          </div>
          <br>
        </div>
        <div><br>
        </div>
        -- <br>
        <div dir="ltr" class="gmail_signature">
          <div dir="ltr">Best Regards,<br>
            Mike Gavrilov.</div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------EF33C0CDB06F06965B4EF6C7--
