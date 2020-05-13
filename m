Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F2FC2D0F6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 02:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14074206F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 02:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="guA87Dwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14074206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B956C6EC13;
	Wed, 13 May 2020 02:39:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92E06EC13
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 02:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJeQvxYpbz26a36DlJwIdWBqgCp4SY1kuIHJNlWWVQJQ0ec5Q/c+ijFLnYuzGYffDl4qxc+fv1296HNI1Ka4qiVsNVdWHYRrKp8A7T8nmjx/ji+iMozHMWXCXC7S0RR5YUzpOSEt7WxqZCasqlo8a0gRQFhHx8rjTpL3NXo4N3xEja8pRyiBaOrYPuC6n3usfD80lHPLtV/HmyRAHCYhejOI2FcLNdKLJm5cRuzePOAPnEjQTWyUShMMZQjk93vSdyJBqX6PVJmW9oJRiKHJqKxyhnl0IO5HCSaCB9KmdQ/mR+QQEz/KQLmZMzyTk1FKsWh/UY7LvMqi8blXd1ZvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jifr65HeOgXRHsA9wP9SV5RVwxeh2h5VXHIwckMpPrE=;
 b=K9TezIlzZHyFGsdwataflz59Ulqk4LDLbMAa032TUTmJNvVrxbKNZQoEMLqtYbPWxHtmRfkWzNqHtV5FkRNHxP31DgiLkH30eAPrxtlyK2pMgWyfWVEqmQqynm01EteZJ/eEgNbNALFRqton2YRj5Rm10MN6WkSsL4mP3m5BJHruxaYUrosGyIggw8md3WV3zRnrBMSg7OmGEJXL7/FMlXEa6OEdl0IAWJ2PEq9uzIBiMPUu9jJ3HLITJMjn+UAuXRQdttA+Bi6I6SOirDaloonf6KpanXOTHWy1kHMf0/0+g2wMdYZ83H7zD1VgYjE+AEP1vzYu4Dl5icTbmqST9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jifr65HeOgXRHsA9wP9SV5RVwxeh2h5VXHIwckMpPrE=;
 b=guA87DwhwjRy6UgBdOUzk/2uIJP5SKX71ZslqB3wpoBmioBGItTMSsKUZQSkYO+atm2GUkflCRtgVQdSV3z8ElQu1apRwz3oZcMM2FasvclKiFwU07WmBpNSmHqzH2NhTkvo6fE6UhyFeS3yOKQ0AWFjKURI0Emi4fOWKALjY/w=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.35; Wed, 13 May 2020 02:39:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 02:39:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/powerplay: ack the SMUToHost interrupt on receive
Thread-Topic: [PATCH] drm/amd/powerplay: ack the SMUToHost interrupt on receive
Thread-Index: AQHWKE5wc/HiLjkaV0Gy4PuDMYKJqqika1eAgADjDzA=
Date: Wed, 13 May 2020 02:39:29 +0000
Message-ID: <DM6PR12MB2619A28F13666023866289F2E4BF0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200512111305.24665-1-evan.quan@amd.com>
 <CADnq5_NXPUM8TEPD8XQ1vgEVUEV5vu2vpGAs+d6cAAzbCowyhg@mail.gmail.com>
In-Reply-To: <CADnq5_NXPUM8TEPD8XQ1vgEVUEV5vu2vpGAs+d6cAAzbCowyhg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3f80be4a-c76b-4ee0-a849-0000f106c50d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-13T02:37:55Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38aa25a3-30c3-42b0-3cbc-08d7f6e6dc40
x-ms-traffictypediagnostic: DM6PR12MB3356:|DM6PR12MB3356:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3356C6A74CAFC4F0551B75B4E4BF0@DM6PR12MB3356.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zIuy7hbiGCAtmyrWIX2pgfrUkk/9l3vyI1r9/pV7MFQO9MnpLigFHsN8vVeTjBG4p4WkQjNGQlxXaxTDT8p/q0j2gVYW+hypnJahKgC+Zso6Od34ajVy5ps3v6ZoeCaZgQcZCnAhceFRywSVbpRpmiJUH/5kuCuDs66hrf/huoRyo/yBe3R9V9e5fd92NLUEFvNI2Po31vyo1UgeSLlDeSlSyoDj1icAGvdMUDP1fc32PzDN9h8dIVs18sdo6IEhLiuj0tlcISHj45WO7etV3vNUML+2N8cnyFjSBNAMRJZSmE5OyYhyQzoPVTI/SEokYktSdpPRr9D6Fv1NNBzQopjjI0BwiNBBaijBhHQJ9xmvNs+DJGUaXutz9sKg9VBQ/CTQkiXkchRXhrtlZrqeDxNXTyX1lYWazwHLl/e6CWMG8prQ7h7shwMxdd+Q08fyPfWmYKVC0RwZ/J7VsoMFZqVmdwbX1hxL7EfTMvlJOVExqYp7751kLk0RYQZgNHz1653QVo5epg4jIy+onWklSdYRGt+13cmlnh+qcT///rA95qFzvwhNIGoBSlkdA2G4sBmdC9sOkuJ1NuGpmpy33htmgzzrjJzn1TUvLOlJ38w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(33430700001)(55016002)(52536014)(33656002)(86362001)(6916009)(8676002)(478600001)(8936002)(2906002)(54906003)(66446008)(7696005)(6506007)(53546011)(83080400001)(45080400002)(64756008)(66556008)(66946007)(4326008)(316002)(5660300002)(76116006)(33440700001)(71200400001)(966005)(9686003)(186003)(66476007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GB3g4l/CtI8cDHe1FWxfxai5y8kCO3tR1cghL0rrzIebt/l83Fbs9MgZLOzjUoGb40DHFACrb46YA/Oh5qlVlEtHfKMGXB33QtrQBlp5TwjyKqAeaqFw69Wwfr0zhrl/aQ3BlsMNitYzyz+0U7WG0sI9WCcz92VVd1in9rqMRJws5fV0g6shWzB5tuBHdj2kUeeAvgExdd3pYRkA44WT1/SEIVLak7nmMM926y1j6TqJgAji3QXc2RoXt6dZkq/nIPg9aBAEY1llxWApfgR/NwYlBo/DIH7uuunPJ0Ohr6yk3Fo6ECPPaEBisTRJLl2U16CsaeAFoGRZwPYisYvXzljpsOAHv1MjXxNzyspo799WD5ZNpuUL69zWIt3wQkOr0LeUoXGFKx2QY0IXnInNbjskAi4j9BcF0m+QTK/VicaWNvWTBFtSphs/sxSXPCbNyMPwkOJf/KcbTDdY5G5PJgXdUiFSACfK1Zi8mxN9sW9X0QOT70QEsfx+ObHSCSlZ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38aa25a3-30c3-42b0-3cbc-08d7f6e6dc40
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 02:39:29.3733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33w1CNKk2tnttanN9h4+3jPkPuSLrbnAqvcfVlRzDsb/Ia5zJ8q9hIlla8YlF6ae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3356
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Just setting the ACK bit is enough and no need to touch other bits.
It's aligned with windows and confirmed by my local test.

Thanks,
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, May 12, 2020 9:05 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: ack the SMUToHost interrupt on receive

On Tue, May 12, 2020 at 7:14 AM Evan Quan <evan.quan@amd.com> wrote:
>
> There will be no further interrupt without proper ack for current one.
>
> Change-Id: Iad5adcaf7dd5c3a773b3d93ee0922a424dba8ac8
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 80d6c296a599..beec4ae0b1d6 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1535,6 +1535,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>          */
>         uint32_t ctxid = entry->src_data[0];
>         struct smu_context *smu = &adev->smu;
> +       uint32_t data;
>
>         if (client_id == SOC15_IH_CLIENTID_THM) {
>                 switch (src_id) {
> @@ -1576,6 +1577,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>                 orderly_poweroff(true);
>         } else if (client_id == SOC15_IH_CLIENTID_MP1) {
>                 if (src_id == 0xfe) {
> +                       /* ACK SMUToHost interrupt */
> +                       data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
> +                       data = REG_SET_FIELD(0,
> + MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);

Did you intend to clear the register here before setting the bit or just set the ACK bit?  With that clarified:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +                       WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL,
> + data);
> +
>                         switch (ctxid) {
>                         case 0x3:
>                                 dev_dbg(adev->dev, "Switched to AC
> mode!\n");
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7Cdd256ffb1af04cd76e7208d7f675247c%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637248855296590946&amp;sdata=vqgWfjcX9Sqqb
> We7plBmWhDVfAuyvwhNABovaafHwiE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
