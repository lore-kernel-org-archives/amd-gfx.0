Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBCC2D0F6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 02:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD704207BC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 02:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yQx7dU4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD704207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC126E088;
	Wed, 13 May 2020 02:59:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C055F6E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 02:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeaYPRxi1XkUIo7XCTN9UByLt9Zy1H4aL8t/oAnjlBiqQYcXFqFOXT+4a2+82rW9/iprGtejYyig5DTQMBTFj7m7t8oe4F2uSQ7AQJPkk+BWwRm5yoLzFwgtl6YfQeaYhpmZEvypr9cTpthkNJJTuwrf/OGvfLW5/G582gLXMW/Mwiq3wlzmIL/bWBoLBqOTZDBNujKgdPj+tpijVKi8tqN/7euzzvc7b7/k5YYpNLHB7XBGKVsadlWu5/MUTu1EwKDGP9sCQgj7qlx69kdf2jAvL/7+RyioWuEBrFaEntZN+vN1gqgozveYCdl3H9wrMGDoNtqzY4URjLku3pv0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvw5kLC8QfHjuMy0J2PsXopgIfFRoyLhXk1f45AcnYs=;
 b=PUFolcGV7i6LFeJQfuoItS8X7KOIAktaAZGbB5hUdAyoITVLKI3VdYKnupW59ex5qmn8nxsVNRvSeEeVNxZviq1VflhauhLs1kji31kBCzqa8IPbHN6Dd8ra62S9j1b5XXjW5pYdfoSRT4vYOWQSJfl43K6tZoSVxnVHH8sB5rZCU2lEcN0hlvsg0L6UoKGhE5KxTb2j5SZEM/8TfHc/78RAjSjmdadwC2T6qn389oUKdfCHj5l+UubBQf1mt2V5ytnbMWWejwoMWDwPzTHn6668mHO9qHT7YfNvNc58smhJHEqktoAJkXYtNT1OCsKxlBP5X+/BW0jjW/RfL6fPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvw5kLC8QfHjuMy0J2PsXopgIfFRoyLhXk1f45AcnYs=;
 b=yQx7dU4zx5zp/jnGYzmsuqT846LN6OJTM7e0eejupPHtSTLd/kBZRE0weJFv/YzTFnISQrsdlvFslRTMeyC2DyHJM9v+hoetbJ0V8N8X81/bX8sPQ2vWqdozW61v6yaqRkWx8b/4lF+8R9rcJj3FA7Mu58c2CxoWS6fmL2lrDcY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3243.namprd12.prod.outlook.com (2603:10b6:5:185::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.35; Wed, 13 May 2020 02:59:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 02:59:02 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/powerplay: ack the SMUToHost interrupt on receive
Thread-Topic: [PATCH] drm/amd/powerplay: ack the SMUToHost interrupt on receive
Thread-Index: AQHWKE5wc/HiLjkaV0Gy4PuDMYKJqqika1eAgADogLA=
Date: Wed, 13 May 2020 02:59:02 +0000
Message-ID: <DM6PR12MB26195E7FE10F3F1B8F450512E4BF0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200512111305.24665-1-evan.quan@amd.com>
 <CADnq5_NXPUM8TEPD8XQ1vgEVUEV5vu2vpGAs+d6cAAzbCowyhg@mail.gmail.com>
In-Reply-To: <CADnq5_NXPUM8TEPD8XQ1vgEVUEV5vu2vpGAs+d6cAAzbCowyhg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8aa16413-232e-4374-8e41-000040b9d243;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-13T02:57:24Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 060f5b68-1aba-4c17-3d1f-08d7f6e997a1
x-ms-traffictypediagnostic: DM6PR12MB3243:|DM6PR12MB3243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32432EBCC63F00984E8A195CE4BF0@DM6PR12MB3243.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1DPYTQOkPIXMf/64+u6enaJS1kwoI2Zv3SHO3dGxwGTEshnKaMmg4A7kyaVmktDL2KS6CO1FI5UuY6F4M5SpvQacOOBFRzNaIzjrSSKL/yyydtDcnJ+ZowWzhOWy+nbeXfdAU6ldm0QcB/NHDVXes3d/A9UalHZkLcuAZ5HYoCvGZ7PYrXtt7kjntLFHSILkkk8mK6lcUuAWrOfCVRbDK7k4k9hG2djEJOPWwUlhyPqZMeyv/AiSvxgAFBvTP7aMB5Fhw+mIGupzQ9VxpFq03Bq9t1pi13lQqsOlZ0wPFcfz9/ubdKSq21MPFjOLr/tJaCZSXiTUrFI2iGXR5L6ofVxMjQjhgGu4JC6DAHanV42JYBpMD0I39rcuFvcwQU/hwGo3rd+AMhCHUBEw3AJJLqIAdnFpxYQTbTbDq1vu7Iunb8s796w/zfR3h2lHDEda1GStzxMolL8JKja+pUsqiSzZwvQ3l+xSmQAwUSenqdS3u6W+LXjktcfjoiri1zyyuF3/HtBNDoUQ2M8vVR4kbzC4jmmDFrBRZDvZCgrGsjbUDufz7z1lt667qRli+HAOoz9Aj1kD5vihw/1gYkBLAE1cM41UeruPHr1xERqJaaE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(33430700001)(83080400001)(64756008)(4326008)(54906003)(2906002)(55016002)(33656002)(6506007)(71200400001)(9686003)(7696005)(316002)(53546011)(26005)(45080400002)(6916009)(33440700001)(8936002)(5660300002)(66476007)(66446008)(52536014)(76116006)(186003)(66946007)(8676002)(478600001)(66556008)(966005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: t5jks70j4+YQW9EwClFFmioj8wWiN7O0c1DtBudoGdDAEv/+ENmLSXchKkAu9TuP8IYi7qZgtn5YgNxmWWl8tGHt6FysOU6dhwbMwOqzuaNtZRDqPkKnRlRmubMt/48RzpYBhT6BW9ga8BpcnwPWXAZWD/1aSktCY+YqR1cnOPf3aqP4Rxz/LYnoFQVLHPb1EhFc5vJzU/u8Ydr6qj/mnLwTFg3T6p4pCAn7d8m7e/wXoWSiDAbQKuqtdmr/YcJz31QQFBdAVksrUYtywsUaJOw2CPgS4r7eQEF5vU3iTnHPoPP81f/YZLSMK62iIZi1eZcI7TS+elP5msVIIhFqgFmjrOm+k/RuWhUYmXwN0JH50gICudVmZnjuPgBAA4HoGgJSueKG7jcrEcEeBQKiP4BPKYOj/jmEzVCXlPFQ618DsFcDFAWtPrEDsgHXRAVPcUALKyAAIce87nRhBkDGLHNWC57eN9gkG6j3T+zvVg+lTTVnWELUlINSwnFLpFyc
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060f5b68-1aba-4c17-3d1f-08d7f6e997a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 02:59:02.5935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kr0xStCcPUqL67u/2VWIqECGMbGAHZdG0zYVME2KqfYSL//q0aSH7NwERI3hdSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3243
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
[Quan, Evan] OK. I see your point. There is a typo here. Should be " data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);".
Will send out a new patch.
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
