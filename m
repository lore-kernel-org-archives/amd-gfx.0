Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE674C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 15:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59493613B8
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 15:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59493613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019766E11F;
	Tue,  6 Apr 2021 15:01:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88D06E11F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 15:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5nL+8rJQibC3JmcsdJ8Uud/xI4kMZ620pAITqNK86hL7yPDJqcIaxjvtS2adNLsHRaTSOyzIIuS0q0iGh/VwXy3vx5gYC1lYpcZL7iwe13qsxxi3hDtnPy87hrNTkrdz5t0QQ+FzQz3SODpdIfCmNp8FJ9/BDhTkdyX9hf0a7tBaOF1xZRU/imi9eRqE//7L/J8K0QILb4mzdofKYR2OJgVQMBD4GHQKima0EC6weYAIamEoNEpsN6VJ7z9qb4b/IfnJf3sSG7/auI476bG3yQzyDeNXyXacnNyud0uvG+NAy+1G+U5af5iOnouB8TpnhIxDklp+h9PEQNylCz+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBqzHd9eLlvZZaLud4KTr/oKlLjqSIAEsTXWz6Ru9gc=;
 b=TGLWpw3ZQLkoPsm7Ry4YOkQqfglpSkDM6bPL+uy28CjGFZ/oKt0Ht39ROu4o2ujQEp7Ly00hs6Zs/giSCD8kqU6RDW8LOc0JEx/AVTcRq7Hgn9jbX5n5+KgKS7QCLXStPFO+KIjxxFn8AOGbgoVpK7VpmKU5nz0QfJ56gCh+r8Jjp+yM8KgQuBVIZ7mgPIW59evEbVs3PWuUjx0A/0TN1Sdh+m38MGhS8u8BMtfmBKwSt2WqVSbzRHyY3pSf8Ah3Pqnoq8rlvI7T7CmdoLevWWdtUx+qvf3o67IJ33K+3XNytX2sNliQbZgCpOi1HWgfS/i7n4OHPs8iO49HUKrqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBqzHd9eLlvZZaLud4KTr/oKlLjqSIAEsTXWz6Ru9gc=;
 b=V/0BHYVP7fsQvC3LanzbpUZLZW2m5KlvWAdSnMW7JR2I48ZMQH62Xc/YLxEJzH9KBgVejUQs6ys10RMw4BCCihu1vsQ+R1JGd1AxOt+Qqe5kh91zzlplqbYx+MyNb1POiapwU+C9ReK55tDkqyoIZMbG7ATan8yLWKXrwgqpPlw=
Received: from MWHPR1201MB2494.namprd12.prod.outlook.com
 (2603:10b6:300:de::20) by MW3PR12MB4425.namprd12.prod.outlook.com
 (2603:10b6:303:5e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 15:01:38 +0000
Received: from MWHPR1201MB2494.namprd12.prod.outlook.com
 ([fe80::3919:738d:65f7:f278]) by MWHPR1201MB2494.namprd12.prod.outlook.com
 ([fe80::3919:738d:65f7:f278%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 15:01:37 +0000
From: "Shih, Jude" <Jude.Shih@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
Thread-Topic: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
Thread-Index: AQHXKupeJ4UitXbZEkKHCOE5W2WpcKqnhXMAgAADjuCAAAPhAIAABJ0A
Date: Tue, 6 Apr 2021 15:01:37 +0000
Message-ID: <MWHPR1201MB24945BD0A778573E7A13096CF7769@MWHPR1201MB2494.namprd12.prod.outlook.com>
References: <20210406134001.46915-1-shenshih@amd.com>
 <bb10f195-2205-a3a0-498f-94668ddb4bb2@amd.com>
 <MWHPR1201MB2494C84F298E6C540BB76314F7769@MWHPR1201MB2494.namprd12.prod.outlook.com>
 <3c30e17b-c1d5-f949-1286-a5b53c00622b@amd.com>
In-Reply-To: <3c30e17b-c1d5-f949-1286-a5b53c00622b@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-06T15:01:29Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0080ece1-207b-4081-ac17-78d28087aac7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [219.84.232.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a64baf2-19cd-4514-7fb1-08d8f90ce0ad
x-ms-traffictypediagnostic: MW3PR12MB4425:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB442585752A63D2C10D24EC3BF7769@MW3PR12MB4425.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MdeoaESN177dfc8AqdnebMRnR8LBpzUmTYoVXNzWxegwJhRiwwg6EtM6LJ6hLqOrJij+i3Pfta1b3WzUeTrWe1kJ9k+ZsREQ3CKkMyZVX3+9ZOunm8t+KsnfOBPISP7m/IE1UgGFcBm0s7Wf2tEhE3ojyOuW23aezve0T1BZJ1m2qJrRF0WM/KwASIeME/45IAj70/W2E6GLNAivIZLY6lnYz3WJeBeSm+DSwJ3s7DvozyaeRwHAs1RQu7lYJrN73QUVzwxdcq8BsqNldyAd3I/OYJ6SIgk0FBCIMxTlbGUAVe72llMwvaCq/E4bJVTR9mx+vpkUXTPZw+4kvI7zKotdUd3KQZEFvtz1mzEb94ox/cMmI6AMhFJTokBL3TGoSAf7sr44cNwJjUEwhqmTYyHk9F0vBN3wmNe90teJ9Nwz82DXxhTNPq4wZdztLYtox9xmCc5/T+Qw6cAkyqRZlh8wwunxjDuk/VPhzK5sRt/523oYJouCNr9fy03YiNTiSbZmKoJTSUuBOSqYukPz7seKCO8rHGAaPNmzRJ1gB4Kb/MmrARYI3kJs4Vq8UN9mFbI5CQOP1x8MqwGfyLELCZbwzBbUrkgNwlICho9si067SKTovk9J562uW+qtXYmt7PTiXCl7WSscY6lvTmRf3TadYkqIDwRNHVwwmgEUsw8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB2494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(76116006)(7696005)(71200400001)(9686003)(2906002)(5660300002)(66446008)(26005)(64756008)(66476007)(6506007)(55016002)(316002)(53546011)(86362001)(66556008)(186003)(33656002)(8676002)(110136005)(4326008)(8936002)(38100700001)(83380400001)(54906003)(66946007)(52536014)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?akp0U3ltRElremxvSEY4MHNJTjNlRklvVnk2TXpnbnpVNTJ5YlRHWk5IMjlI?=
 =?utf-8?B?VERHcHhReE1IdldhTUlaY3RkTTJtQlkrK0dXVVlkWlV4akJaQ3lOLzl3L0dz?=
 =?utf-8?B?amo2S1ZMZHhuV3VvTnhwN1gzZXpnQzdmekVTR3hGcUJKaXdrWTVTMWxQWWsx?=
 =?utf-8?B?MmNwYWpHVkRaQ2ZCdHRhWGZ0K3R1WW9aRHQ3b2hneFZSWWhRM0RNUFJkUEVQ?=
 =?utf-8?B?YzNzQWRlSE9oVVBIeHA1QmpUWUVXbUw4S2pWS1NQNVBZZEhTR3VGSVFRTnNi?=
 =?utf-8?B?cndDV3ZmN2VyS0w3VldFYkRiMGFaeW41d2RHVlpEaER2NStXK2FnSHg1Y3RZ?=
 =?utf-8?B?T2ZPbk12b2htbHlVTTdoMzRpUkFhRDdCTGlWZE9VbFVuM3IzQW10U0U2WUlK?=
 =?utf-8?B?SnB2SEJaR2NqVHpZLzN6MFliaUJ1RmJHZGVwVm5FTnRYaVFyc3ZJbFdyVnBx?=
 =?utf-8?B?c3J0R2U4MzlhRk1ITnhZSk1JVzExeSthR1Z2NmZBODdVOU5ZNWxBVzVVV3FW?=
 =?utf-8?B?R3NhazRhblVreFBiRGpMRUJrdXpCV3k4cjdXdkk4a1l5b05uRmk5Y3NsM0F0?=
 =?utf-8?B?dUJZbm9vNURPL0pGN2czZFJ2UytqekhmSVV2TTRBNjFjWFhpdmx5ajBUdGZF?=
 =?utf-8?B?L2NKODJXYmgvKzlvU1JGZzhrZ1RLK1ZjQTJqejdHbWJsWHhoY0pwS2N5eldK?=
 =?utf-8?B?QmxuUTJtSGloSHFhbDVjQ2d6bW4wNmxXNzhhR0piUW95cHh3alZxajM2YzBi?=
 =?utf-8?B?UldtbGhTbTBTR2ZYamtOYmtPY3JrYURUTlEzaC8zSUJEVVJIVktpUGx0eDZU?=
 =?utf-8?B?VVdCTmFpdXdISmJIZjU1Z3F0MEtZRzFDMnQvLzhVYnJNdVJmMDk2Uk9ia1l1?=
 =?utf-8?B?WlVXblBFdzhiQU16UDZnMm8vQVQ0NkZocnBLbmVxa05GT3ZwdzZsMlk4a0ZJ?=
 =?utf-8?B?UDJYZVdDc0RxSlhzTTdRdEdzRmpEWDRJVElpT3FCdnNFRVlhSG9VQ285a2hr?=
 =?utf-8?B?VXY5SUJhb2xCVHVKaWppNUNndVp3U2tScTQ1ZTFqZ0R4aWdJRnRzM3dPWkdL?=
 =?utf-8?B?MVhtMFJPTFl1VGZscURGQy83bEJieDIrRmdSK0h1T1I2cEhXaHZ1czM0ak1O?=
 =?utf-8?B?UlpmT3NWTXpxVHFWR1JOazFwZ0pRdjRCL3hZZlVPK3BPYXBnQmVEKzhDeWpk?=
 =?utf-8?B?aytvRE44am9oY2ZjWTlEdGdTc2dUSTRUSTlxcVpmVmU3bm1EblFWT3RoOE1J?=
 =?utf-8?B?b3ZnaHAyY1BaQWt1MGFwNjNqUEpmNHkxY3ByQm9iTDBMZWxrUUFGTGFWQ3RG?=
 =?utf-8?B?UTlXeWVBNkVwR0c5em9QQXRiM1F2Tk8rYURkQWFoZlFKbFMvQVVhVDlYNVJ1?=
 =?utf-8?B?S3FMUTA2V0ZHSDVNN0E2Nno2bjhLTWp2SVI5VVlLeERVMFBYQXVtSHJoUU5V?=
 =?utf-8?B?bWZHRU45c3J2bXp1d1dyNW0yc3JKcGlZNDBuT2dFQTBJYW9FbkV4ckNYd0Ni?=
 =?utf-8?B?Z0hrZjF4OERlWU1PZCs3UXB2RjZkMVVoYmRIQzZ1V01YVDAyeUI2UXJsMWpq?=
 =?utf-8?B?R2FVT0cwR0t0aXdsTjBKVGc4N250NCs0V2U0dGhvSi85OCt0bzNSVnIxUG0x?=
 =?utf-8?B?c0puL0U1UXlnQUpGUldsYTlrekd2MmFiK1E5Y25SUG0yZWxRZWc4YkM5Rmh2?=
 =?utf-8?B?NTJZb201UGlSQ0YyQWxIUnQrRVV0a2loY1FnREdNNVV1VDNQL0NIUDdzSVNY?=
 =?utf-8?Q?sTycRZGTEKQLAqv/iHa4mGQmw8nxuPrLR1Y9BcY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a64baf2-19cd-4514-7fb1-08d8f90ce0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 15:01:37.4946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0xJIMfnqzzYJCQyt+IdrEKhS6HOD/QOieVJqFgPMPXrrrCtKzcwA7Bn/bV9ayPJ41ccHkhtq3uEO8p8XT+xJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hung,
 Cruise" <Cruise.Hung@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Nicholas,

Let me summarize the suggestion. Please correct me if I misunderstood.

1. for dmub_aux_transfer_done, move it to amdgpu_display_manager in amdgpu_dm.h instead of amdgpu.h
2. Remove DC_ENABLE_DMUB_AUX from amd_shared.h at current stage since we don't have a mechanism to check the firmware yet. We just hardcore this flag when testing.
3. Keep the irq source change in irqsrcs_dcn_1_0.h at current stage since we don't have irqsrc_dcn_2_1.h

=> So I will just keep the change in irqsrcs_dcn_1_0.h and dmub_outbox_irq in amdgpu.h?

Thanks!

Best Regards,

Jude
-----Original Message-----
From: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com> 
Sent: Tuesday, April 6, 2021 10:30 PM
To: Shih, Jude <Jude.Shih@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Hung, Cruise <Cruise.Hung@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source define/complete/debug flag

On 2021-04-06 10:22 a.m., Shih, Jude wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi Nicholas,
> 
> Does this completion need to be on the amdgpu device itself?
> 
> I would prefer if we keep this as needed within DM itself if possible.
> 
> => do you mean move it to amdgpu_display_manager in amdgpu_dm.h as global variable?

There's a amdgpu_display_manager per device, but yes, it should be contained in there if possible since it's display code.

> 
> My problem with still leaving this as DC_ENABLE_DMUB_AUX is we shouldn't require the user to have to flip this on by default later. I think I'd prefer this still as a DISABLE option if we want to leave it for users to debug any potential issues.
> => do you mean DC_ENABLE_DMUB_AUX = 0x10 => DC_DISABLE_DMUB_AUX = 0x10 
> and amdgpu_dc_debug_mask = 0x10 as default to turn it off?

Don't modify the default debug mask and leave it alone. We can still have DC_DISABLE_DMUB_AUX = 0x10 as a user debug option if they have firmware that supports this.

Flag or not, we need a mechanism from driver to firmware to query whether the firmware supports it in the first place. It's not sufficient to fully control this feature with just a debug flag, there needs to be a cap check regardless with the firmware for support.

Older firmware won't implement this check and therefore won't enable the feature.

Newer (or test) firmware could enable this feature and report back to driver that it does support it.

Driver can then decide to enable this based on 
dc->debug.dmub_aux_support or something similar to that - it can be
false or ASIC that we won't be supporting this on, but for ASIC that we do we can leave it off by default until it's production ready.

For developer testing we can hardcode the flag = true, I think the DC debug flags here in AMDGPU base driver only have value if we want general end user or validation to use this to debug potential issues.

Regards,
Nicholas Kazlauskas

> 
> Thanks,
> 
> Best Regards,
> 
> Jude
> 
> -----Original Message-----
> From: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
> Sent: Tuesday, April 6, 2021 10:04 PM
> To: Shih, Jude <Jude.Shih@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lin, Wayne 
> <Wayne.Lin@amd.com>; Hung, Cruise <Cruise.Hung@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source 
> define/complete/debug flag
> 
> On 2021-04-06 9:40 a.m., Jude Shih wrote:
>> [Why & How]
>> We use outbox interrupt that allows us to do the AUX via DMUB 
>> Therefore, we need to add some irq source related definition in the 
>> header files; Also, I added debug flag that allows us to turn it 
>> on/off for testing purpose.
>>
>> Signed-off-by: Jude Shih <shenshih@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 2 ++
>>    drivers/gpu/drm/amd/include/amd_shared.h                  | 3 ++-
>>    drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
>>    3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 963ecfd84347..7e64fc5e0dcd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -923,6 +923,7 @@ struct amdgpu_device {
>>    	struct amdgpu_irq_src		pageflip_irq;
>>    	struct amdgpu_irq_src		hpd_irq;
>>    	struct amdgpu_irq_src		dmub_trace_irq;
>> +	struct amdgpu_irq_src		dmub_outbox_irq;
>>    
>>    	/* rings */
>>    	u64				fence_context;
>> @@ -1077,6 +1078,7 @@ struct amdgpu_device {
>>    
>>    	bool                            in_pci_err_recovery;
>>    	struct pci_saved_state          *pci_state;
>> +	struct completion dmub_aux_transfer_done;
> 
> Does this completion need to be on the amdgpu device itself?
> 
> I would prefer if we keep this as needed within DM itself if possible.
> 
>>    };
>>    
>>    static inline struct amdgpu_device *drm_to_adev(struct drm_device
>> *ddev) diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 43ed6291b2b8..097672cc78a1 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -227,7 +227,8 @@ enum DC_DEBUG_MASK {
>>    	DC_DISABLE_PIPE_SPLIT = 0x1,
>>    	DC_DISABLE_STUTTER = 0x2,
>>    	DC_DISABLE_DSC = 0x4,
>> -	DC_DISABLE_CLOCK_GATING = 0x8
>> +	DC_DISABLE_CLOCK_GATING = 0x8,
>> +	DC_ENABLE_DMUB_AUX = 0x10,
> 
> My problem with still leaving this as DC_ENABLE_DMUB_AUX is we shouldn't require the user to have to flip this on by default later. I think I'd prefer this still as a DISABLE option if we want to leave it for users to debug any potential issues.
> 
> If there's no value in having end users debug issues by setting this bit then we should keep it as a dc->debug default in DCN resource.
> 
> Regards,
> Nicholas Kazlauskas
> 
>>    };
>>    
>>    enum amd_dpm_forced_level;
>> diff --git 
>> a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
>> b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
>> index e2bffcae273a..754170a86ea4 100644
>> --- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
>> +++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
>> @@ -1132,5 +1132,7 @@
>>    
>>    #define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
>>    #define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
>> +#define DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        0x68 // DMCUB_IHC_outbox1_ready_int IHC_DMCUB_outbox1_ready_int_ack DMCUB_OUTBOX_LOW_PRIORITY_READY_INTERRUPT DISP_INTERRUPT_STATUS_CONTINUE24 Level/Pulse
>> +#define DCN_1_0__CTXID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        8
>>    
>>    #endif // __IRQSRCS_DCN_1_0_H__
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
