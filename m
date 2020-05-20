Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7303BC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4592520874
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F1C9zzf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4592520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 112B56E8BD;
	Wed, 20 May 2020 22:07:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8EB66E8BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 22:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPEQVpuAKWRwa3C4NFN+oavLbjfFomNp8ImlP83UAl7ryUkJkxAbp8ykGCrQB69gTBmx8IG+j9Xo/v0G0sn2fee38vH7m9ALmDAh/Rxn+GD2nkk1BbovwLcgP0m+pRMAKvdBoKOa5XFyt9+K/85hwHR1c9ap4CT4Fp8qJgp1qZuVMgPbLhFf6xp+6x7/fES37kZmgLLlRqyXNDlQ1KcTHGk9I4IzFjTh1rnh6vuoekvJcsmgkjxlGIrZ0d6QwsU662McbMJtawUCCj9SsWn2qZcWgjtQozgT8THYD/u6bIgNrZjXStSVUavw3bXHV9Y6wun74jEiz+EeFp5EneWosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5OwPUG1a7GFjFamr24+We5xJWvdTVJO14VHA3M4vtA=;
 b=Cig4dWj+xY9uzFI8l1uhWNp55C0e0mz1FPOkTdUDhbITBI2thwegiFGjKMMV9XtspU0EwmNfsu6iz31KaIfGqa8LLrREfAR1/IOvOUUMByNRMWu+Vx9EPJTQ5uwm6t68r+NsPJBiuydB3JNwyscHZpI6CTRzamP0JeNM7Obsfq1ts6t2F35uutKUkFmkgVMoip9Xf0cfcuiAw42oiJ+0j67E4S+RrX14ELNBbYB3gUm/38FjDw3CJcgFoJxFyI6eex+dpnaSbySQymv2oC2dZGUXb0Ub3LoKl+n5D1mdWXHImR4dl1jt7b/6+rfthfgEx9ym3lD+6quQXjSwxSuPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5OwPUG1a7GFjFamr24+We5xJWvdTVJO14VHA3M4vtA=;
 b=F1C9zzf/GXrjIdb37ZA8mTdntbH6BoaJAQ0SzTR19+mwfnmnBUyCJnZa2EjcgjWBKo4IfzsbJt89/m7VAICicgi1HOSqf5lZvFit5Jopy9nbQOCbiwW++yEdTPSSwD2ZORi+WVWITRVqYFy8JGO3ErgNtwiHjwMvh6kHKSIEzEc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 20 May
 2020 22:07:27 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 22:07:27 +0000
Subject: Re: Flaky brightness on Renoir
To: "Koo, Anthony" <Anthony.Koo@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Alexander Monakov
 <amonakov@ispras.ru>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
References: <20200520213638.1896-1-amonakov@ispras.ru>
 <CADnq5_OmxeZ3yEOGjCjJgOdi_-PTJ-8KhLzz7nnx_yvVLjSe9Q@mail.gmail.com>
 <792858ed-d675-ce6b-07c2-12002874ffd5@amd.com>
 <SA0PR12MB4560B79A71B3CEE54D37E45AF3B60@SA0PR12MB4560.namprd12.prod.outlook.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <cbba4d03-b4a2-1357-b5ba-1caf01a25f4f@amd.com>
Date: Wed, 20 May 2020 18:07:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <SA0PR12MB4560B79A71B3CEE54D37E45AF3B60@SA0PR12MB4560.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:404:23::17) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.4.158] (165.204.84.11) by
 BN6PR03CA0007.namprd03.prod.outlook.com (2603:10b6:404:23::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 22:07:25 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8d36c7c-3f96-4288-6f09-08d7fd0a2ee6
X-MS-TrafficTypeDiagnostic: MW3PR12MB4522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4522706FB47D25745285352C8CB60@MW3PR12MB4522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuSeKff2126SfRMAxW3vCChAmg4He/mUCirihpCrgZfNi0kwLSe+BWXwYzbCWp9j4GqX4hwfNuOsm6K9Lb9UckBV0VZOlxac1IkJLd/YX1JTPnFUodTfVZrY4k4hn0JLz5qNAxX3Xc3QBWaIxABl2I4rvjcNQll5Xb1a6TKLuC81fS81IZM6dRm7Exy0Mx8EZIrbZa9pfkwKBcRRkY1GdA+Cg3R1+6IrxvFXRp38T5qIgic4FKPTh9Dfs/88MCY+oK0aEgWPAochN32h2SIPgaGMNgMJuZAxdZGYOku1GRFULc6tHpeva1/4dZN1DFvxrLaAHyLZkV2cF3Lk70+AGxzQqwwhO0tAGqbPgyq4H8e8HXCqdvOsIiuK/GrWL9vZVgtuMOWzrwcDKAuKxBABkEJ5LLBo2R7EXpxxZx5WbTUjFxL0kD154LqNLXi9NGog
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(66946007)(66556008)(66476007)(5660300002)(52116002)(4326008)(478600001)(956004)(966005)(31686004)(2616005)(6636002)(2906002)(26005)(6666004)(16526019)(8676002)(110136005)(186003)(16576012)(6486002)(3480700007)(54906003)(8936002)(36756003)(316002)(53546011)(31696002)(921003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PI5O3QQSi9mRLAWmKn3clmsuCPeqsaKDPbx2Vck1HR7+17YhJrpF/eqU9gyHYmcE1W8bHQjlZBqZeea0Y+TUfyw3NzqBMDXhMxkRnPXioUmhYePwGNSMSk+S6wTiye/YybQS9hL/n+b+lHIeI+Dohfaq6msBhmAQl8j0/uAQfr0ujItHc0eLEVNMT9tuAl2m640j1Vh3kEA9334ne30oyIi0oIV7PJADZQiaJvLQ7WdZ8q5G5X9aOmqenmLFBTESTQqY1XxE9pkqHjcYfKjjdUgVaazpnBi7yDosMPMnHNijYhoUh1eRQeWKQmSPZiWl+9kTmKwAIPq1NyL8gXL7YJprB9WPxF+pP/u4JWBHUl64WKIcr/Iv1Oy9L13Wgszq33LsVvk3gHi5yyR5LTDxfw60SgZGDAkcU7wPyNsUjn7BV0DmorDINlcJb89wDTMC310N5l7LUFfolpsLxeRicFelYM3Zr7LLcjgvo9p1tEsz3GuFBVykmtLpWZ1do+9p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d36c7c-3f96-4288-6f09-08d7fd0a2ee6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 22:07:27.6559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOTFxxZsKDdhoh+ZhW6zIJzzFeFuD2e6FexT4kUegToOBlqqv1Kgqgt+k9BIwpqjer0zMSyBeNY2qiYJY4alWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chiu,
 Michael" <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-05-20 6:03 p.m., Koo, Anthony wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi Harry,
> 
> It does sound like a firmware issue.
> I think we will need to do some investigation here. I would be curious if this is a driver regression or just never worked (not sure how new the driver being tested is).
> 
> This point below seems to indicate the firmware might be using some uninitialized values in some if its calculations.
> Typically these value would be things like backlight characteristic curves that are passed to the firmware via a table generated in the power helpers file, and programmed in our dc code.

Do you think this could be related to Wyatt's endian-ness fixes?

Harry

> I'm not 100% sure this is the problem, but it could be something we can take a look at from dmcu_load_iram.
>>> There's a bugreport on the tracker from a person with the same laptop
>>> model as mine that says that the threshold may vary from boot to boot.
> 
> Thanks,
> Anthony
> 
> -----Original Message-----
> From: Wentland, Harry <Harry.Wentland@amd.com>
> Sent: Wednesday, May 20, 2020 5:53 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Alexander Monakov <amonakov@ispras.ru>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chiu, Michael <Michael.Chiu@amd.com>; Koo, Anthony <Anthony.Koo@amd.com>
> Subject: Re: Flaky brightness on Renoir
> 
> We've seen similar problems internally.
> 
> Michael, does this "fix" your issue?
> 
> Anthony, looks like smooth_brightness is problematic on (some) renoir systems. Thoughts?
> 
> Thanks,
> Harry
> 
> On 2020-05-20 5:47 p.m., Alex Deucher wrote:
>> Adding some display people.
>>
>> On Wed, May 20, 2020 at 5:46 PM Alexander Monakov <amonakov@ispras.ru> wrote:
>>>
>>> Hello,
>>>
>>> I have a laptop with the recent Renoir SoC. Screen brightness is
>>> controlled via the amdgpu driver. Unfortunately it doesn't work
>>> properly: brightness doesn't go below a certain threshold. In one
>>> experiment I've found the threshold to be about 95 (of 255), which is
>>> quite high.
>>>
>>> There's a bugreport on the tracker from a person with the same laptop
>>> model as mine that says that the threshold may vary from boot to boot.
>>>
>>> So far I was able to find a workaround: avoiding
>>> dmcu_set_backlight_level like in the patch below gives more reliable
>>> backlight control (but at the expense of breaking "actual_brightness"
>>> sysfs file, because it reads from DMCU registers).
>>>
>>> What might be the problem and can I help investigate this further?
>>> Would really like to see this work properly.
>>>
>>> Alexander
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>>> index b8a3fc505c9b..3274b0d15893 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>>> @@ -428,7 +428,7 @@ static bool dce_abm_set_backlight_level_pwm(
>>>                         backlight_pwm_u16_16, backlight_pwm_u16_16);
>>>
>>>         /* If DMCU is in reset state, DMCU is uninitialized */
>>> -       if (use_smooth_brightness)
>>> +       if (0 && use_smooth_brightness)
>>>                 dmcu_set_backlight_level(abm_dce,
>>>                                 backlight_pwm_u16_16,
>>>                                 frame_ramp,
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
