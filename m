Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365C6C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 19:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0896613BD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 19:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0896613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFEB6ECC0;
	Wed, 12 May 2021 19:01:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAF26ECC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 19:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYO6fgt34/MZ2DvssD0mFFsUkc4bByopSc1ys4Ax8I+7Kfx6EjMzJqhsIW0jM9BKXGYAlqEf0NRXVoJ6TijztfnGHXHYsErmHdMw8viIqXMikz0/LWgGNqpVljziLFGwbC+GhAKpMGCAVeKCaWuD8YxdEG8fKa7/OG8ZuEbvPAFKWSjIgc1eiHa089tLDSX+9m7IAHWxcpIHRIUvuocXHpV9ul7KSbRuDyRJF2yV2ENUxesZnOqxItaT4pfpfmFlQVUlhhYbuCGDzB4BsOAG092FfxrYB059MNB4keWaLBgzkDxH6WYNfbjl1Xu478AefCZ7CCqNVWgU/XReSbRnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gL5Umzlo/z/kiuYgzGmBm9oaz0946Wnjplf8e8PRMY=;
 b=eg13Fkb6KXCrQvjKbpnXXP19cYi0aLH375OuAFot+sCBr3b9nCQYsGDc2nROUOhG0eQUXP4BHQ9JcHIMAhW76Eb0KlKQTXWMd5sSIbZpiFOgszCcUX8NhrbOuj1O8GA4E0O9QmlB9AhG3dB+cWp1z7sfN4Z6+w6hhmNlbUI3zkcuPlzkUW+5SOkb/Rcu1r6fJYykvWj25j8gWNJZHB/8wxoPDTMo0ny1BUROH2iaTvVCCbJxVnLXInEkBeK25S6FBBvZR6INHW1cpIkDJrXZUX0F3g04SrnbwmWTSzqItErcUxxTuYEBPDWioiGe8hZT3oLJy7CWTiW1UeFe4+QmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gL5Umzlo/z/kiuYgzGmBm9oaz0946Wnjplf8e8PRMY=;
 b=PUnP5gdJp1SETwgCopiYKIAU5LkSQRGOZsVKsiqs79OphPb5/7OPaqfvWwRLsxFzb8AOb0GB/EKWaObX39m6S862wgbPJMX0dk9zN0sjdP/EofmLFyvKxCO9hncVGLelr0InlPAHVw2lV07TkHNFWadbZATRVmWSk/Oct9/JAlg=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 19:00:59 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::8ce9:f643:9ce6:af9c%6]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 19:00:59 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Thread-Index: AQHXRs6Uco2r7eCCPEW3XTp7lQLNb6rflw+AgACR7NA=
Date: Wed, 12 May 2021 19:00:58 +0000
Message-ID: <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
In-Reply-To: <YJuhs1WsqtJ7ta1L@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-12T19:00:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e3c58048-00ca-48cc-912f-b65b7ce3deac;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: Responding to a public review.
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.137.116.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9807fb3b-638b-4876-a917-08d91578478f
x-ms-traffictypediagnostic: DM4PR12MB5182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB51820624D6128DB981B1FE22EE529@DM4PR12MB5182.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlYRlo2c3VCxuasN1RqXh1FtepfURc4HXaoY0DHaM+/WJbUYZYIo2X9jR3UPG1iwn1PHh+tR1eBkjSgjyY3lnHhQP3XyH8AMdCmeY5+PbCfvXhitV5UNjcQo3hsJG6Zo+TqKsWFg8qKhSHGyk+e+F0CWUTvkVNtpwG194cxaArdgSuzzwCsErSJ3OG34HaggfEtWS8G/PdfvIuR6QxKKNWaVucdxAXqyka5ftYS+eTLVFEsXRDRzGu5I/RqzLkkn/tS60jofJlOP7c8dy1XuO5olT5bIAl67ycrM/1bHN12+5HNh7Rs6NH75oQLQcoGmDIUmCQLe0Z7pzpUMf/3eJosSV44Y5Qy5eR3Edt8S6Ixf4yTGDCRQu7Sx6POSD7q55vTCGb5979cuRfX0HFeAUITIXtxdJU+k0QksKBmgE3ZIN0SB5SsrAAFUEu6NTNmvXML4A32mRqSNB/TXSSqbFccdI9hbMlCNl1zK8wAlwLs/7zfn2+4CevasvA7JGCLNxGaCCp6+NrrgXDEf4Ti5j9/510i6I355FyU6bDZWGXUdpWeW8pfWPXRISmffE+NRbAGGKW+Au4YO3cAwZdnA4Jr9LEOPJcDtc8I3tlk5UCME94chtD5hPp0QdF+o/7ISI7jszqpHkwev60O8n8TCjGH2X2Xw1jPeYOpL3ShaFx08yiHVVatga2HcVopT/cgi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(45080400002)(478600001)(316002)(966005)(54906003)(2906002)(9686003)(5660300002)(55016002)(52536014)(4326008)(186003)(66946007)(66446008)(66476007)(6916009)(76116006)(64756008)(66556008)(71200400001)(86362001)(8936002)(83380400001)(122000001)(38100700002)(26005)(6506007)(53546011)(7696005)(33656002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lAU47VTFopDABBxTqE0ozhtbMwNiCNMlYpqRtFQwOL99mG/PDJhUgQUEPBXN?=
 =?us-ascii?Q?R+SUxdwm02hoMhm7tFXKB1cDehSd9YICZSwbKLpFAc9PqWXKpn6siEkNoboD?=
 =?us-ascii?Q?1WNXlVasI1TITnLCp+PDmHEeCVVEqJQVwBWJ9zeVc61yOfXKc5C0LcLalqa1?=
 =?us-ascii?Q?rcek4l1AkVFtysBts/Zgz34HDMLN6OxOrI0S5u399NMDu4Njg4DmZfWFFQok?=
 =?us-ascii?Q?LtSfS2cJLQFT7ynQV1VeggptqU7Xbsfp66ElIlJaxtCAU0z/sIQxyuCQul++?=
 =?us-ascii?Q?M18QjzlIUEvz4lklK4EYG0gE9SbwW9MeRVq7wbEM6xRj20WNW6niNxpqfKZO?=
 =?us-ascii?Q?ADlmtsF9EUTXRiefYdnDT+nGErFmUnbvgqDJzciz+b6ZMkWpxmeHmmjInR3E?=
 =?us-ascii?Q?5SRCPgMokAp2wXgoR03+9KSB+3SQfMFaC5/mZNi5j3YIR/UyIYW7vXvzVFus?=
 =?us-ascii?Q?+Tso8bVpfWxrVnlZeWsrjwlK/TPp1uH3PLZlQbaFV3iIJy0UxFtLRt2dhW9N?=
 =?us-ascii?Q?m/GatQcUuIQZ5WtomTBDciaqgcImvgyIWHHfHnnTCB6HXlYFZ0RYlvKAq0ht?=
 =?us-ascii?Q?Lkufk35n5OGCqQrIp4vdMuz/7RrE3FjHaUiiB9WQshAWhilszjgSvp67eUJH?=
 =?us-ascii?Q?t8u2K9PmdIBArIpnS2BlpV2RxEQ44aUpL7F9yt0Ln0M+Lo9VbELftQX+j0QW?=
 =?us-ascii?Q?mTJsqfHHouU4ckLWB6N8Ry7YLb/yc79Ewi3pAm3aGZXE1r5SLixD5bY4MmZP?=
 =?us-ascii?Q?wAwVB0an32yG7FNeh2f3ENQSxGnUgdwc55R6BqpP0yLmPwkZIoPEmmAjBDaw?=
 =?us-ascii?Q?88lrEWMOoYaBftY1SAuviETRyHEIJppPZRBOFPyOrh9AC80BxoJJocNqFa41?=
 =?us-ascii?Q?8XjYtyYYh6XBGDPAeRQ7BbZG/vzwLCLrePcle53dNoPkBQ79RZFySwQpOE5c?=
 =?us-ascii?Q?rW6+v/KB8jsNSEp3Mmu4WunlZdLQDYwfp8iZXAEu9P3Dey9srhhv0BzhBxyD?=
 =?us-ascii?Q?TvunVKsG2R0wKHfmR5fCn62Kf0UtBzSZfwG4HYytBPj0YbSpWK9txojKFxj9?=
 =?us-ascii?Q?GYNEuXQ3U3yM8BfHrRegxAziQnlLlC/9I67UoN3BYifyndqolrcNI6NkHet+?=
 =?us-ascii?Q?wg7dVbtq9NeaY9/zk4xyiu6n1lcM4fDUr7PUNAs+reD9itmV0GFMIS3tXeME?=
 =?us-ascii?Q?76I8SDFjdbLzB/V7ncOyxvGHEGvQJUBlcRl4lkOodOYvKihu/jLnbLri5AV4?=
 =?us-ascii?Q?Uq/NnK5+0LRzR+tShf3nRDbkJEytTF0pw/xVAuK28vWHCxr8asmMisvr7Fvm?=
 =?us-ascii?Q?/ADZnM28/A9EhkqLF6fbQ0nA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9807fb3b-638b-4876-a917-08d91578478f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 19:00:58.9406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLugezwNhz9VGGMWMq5yjWq7dGCtp/4lOlt8H/p598nNMCjwEOoQm6VD6q9XLphSgPiqEogKRlMtBi5VBwG+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
Cc: x86-ml <x86@kernel.org>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, lkml <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]


> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Wednesday, May 12, 2021 5:37 AM
> To: Joshi, Mukul <Mukul.Joshi@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; x86-ml <x86@kernel.org>; lkml <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
> 
> [CAUTION: External Email]
> 
> Hi,
> 
> so this is a drive-by review using the lore.kernel.org mail because I wasn't CCed
> on this.
> 
> On Tue, May 11, 2021 at 09:30:58PM -0400, Mukul Joshi wrote:
> > +static int amdgpu_bad_page_notifier(struct notifier_block *nb,
> > +                                 unsigned long val, void *data) {
> > +     struct mce *m = (struct mce *)data;
> > +     struct amdgpu_device *adev = NULL;
> > +     uint32_t gpu_id = 0;
> > +     uint32_t umc_inst = 0;
> > +     uint32_t chan_index = 0;
> > +     struct ras_err_data err_data = {0, 0, 0, NULL};
> > +     struct eeprom_table_record err_rec;
> > +     uint64_t retired_page;
> > +
> > +     /*
> > +      * If the error was generated in UMC_V2, which belongs to GPU
> > + UMCs,
> 
> Why does it matter if the error is a v2 UMC generated one?
> 
> IOW, can you detect the type of errors in GPU memory - I assume this is what
> this is supposed to handle - from the error signature itself instead of doing
> is_smca_umc_v2?

SMCA UMCv2 corresponds to GPU's UMC MCA bank and the GPU driver is only interested in errors on GPU UMC.
We cannot know this without is_smca_umc_v2.

> 
> > +      * and error occurred in DramECC (Extended error code = 0) then only
> > +      * process the error, else bail out.
> > +      */
> > +     if (!m || !(is_smca_umc_v2(m->bank) && (XEC(m->status, 0x1f) == 0x0)))
> > +             return NOTIFY_DONE;
> > +
> > +     gpu_id = GET_MCA_IPID_GPUID(m->ipid);
> > +
> > +     /*
> > +      * GPU Id is offset by GPU_ID_OFFSET in MCA_IPID_UMC register.
> > +      */
> > +     gpu_id -= GPU_ID_OFFSET;
> > +
> > +     adev = find_adev(gpu_id);
> > +     if (!adev) {
> > +             dev_warn(adev->dev, "%s: Unable to find adev for gpu_id: %d\n",
> > +                                  __func__, gpu_id);
> > +             return NOTIFY_DONE;
> > +     }
> > +
> > +     /*
> > +      * If it is correctable error, then print a message and return.
> > +      */
> > +     if (mce_is_correctable(m)) {
> > +             dev_info(adev->dev, "%s: UMC Correctable error detected.",
> > +                                 __func__);
> 
> So put yourself in the shoes of a support engineer who starts getting all those
> calls about people's hardware getting correctable errors and should they replace
> it and should AMD RMA the GPUs and so on and so on..? Do you really wanna be
> on the receiving side of that call?
> 
> IOW, whom does printing the fact that the GPU had a corrected error which got
> corrected by the hardware, help and do you really want to upset people
> needlessly?

Agree. I will remove this debug print.

> 
> > +             return NOTIFY_OK;
> > +     }
> > +
> > +     /*
> > +      * If it is uncorrectable error, then find out UMC instance and
> > +      * channel index.
> > +      */
> > +     find_umc_inst_chan_index(m, &umc_inst, &chan_index);
> 
> That's a void function but it could return a pointer to the instance and channel
> bundled in a struct maybe...

Maybe. I hope its not too much of a concern if it stays the way it is.

> 
> > +
> > +     dev_info(adev->dev, "Uncorrectable error detected in UMC inst: %d,"
> > +                         " chan_idx: %d", umc_inst, chan_index);
> > +
> > +     memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
> > +
> > +     /*
> > +      * Translate UMC channel address to Physical address
> > +      */
> > +     retired_page = ADDR_OF_8KB_BLOCK(m->addr) |
> > +                     ADDR_OF_256B_BLOCK(chan_index) |
> > +                     OFFSET_IN_256B_BLOCK(m->addr);
> > +
> > +     err_rec.address = m->addr;
> > +     err_rec.retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
> > +     err_rec.ts = (uint64_t)ktime_get_real_seconds();
> > +     err_rec.err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
> > +     err_rec.cu = 0;
> > +     err_rec.mem_channel = chan_index;
> > +     err_rec.mcumc_id = umc_inst;
> > +
> > +     err_data.err_addr = &err_rec;
> > +     err_data.err_addr_cnt = 1;
> > +
> > +     if (amdgpu_bad_page_threshold != 0) {
> > +             amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
> > +                                             err_data.err_addr_cnt);
> > +             amdgpu_ras_save_bad_pages(adev);
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block amdgpu_bad_page_nb = {
> > +     .notifier_call  = amdgpu_bad_page_notifier,
> > +     .priority       = MCE_PRIO_ACCEL,
> 
> Nothing ever explains why this needs to be a separate priority. So how about it?

I wasn't really sure if I should use the EDAC priority here or create a new one for Accelerator devices.
I thought using EDAC priority might not be accepted by the maintainers as EDAC and GPU (Accelerator) devices
are two different class of devices.
That is the reason I create a new one. 
I am OK to use EDAC priority if that is acceptable.

> 
> > +};
> > +
> > +static void amdgpu_register_bad_pages_mca_notifier(void)
> > +{
> > +     /*
> > +      * Register the x86 notifier with MCE subsystem.
> > +      * Please note a notifier can be registered only once
> > +      * with the MCE subsystem.
> > +      */
> 
> Why do you need this? Other users don't need that. Do you need to call
> mce_unregister_decode_chain() when the driver gets removed or so?
> 
> > +     if (notifier_registered == false) {
> 
> This is just silly and should be fixed properly once the issue is understood.

A system can have multiple GPUs and we only want a single notifier registered.
I will change the comment to explicitly state this.

Thanks,
Mukul

> 
> --
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.
> kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=04%7C01%7Cmukul.joshi%40amd.com%7C1c231207786
> 446018e7208d915297942%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637564090158211378%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
> =7LSOnoJWrTf5z96YFACxuRKZP1z4E4zkvtrNzjbTaPs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
