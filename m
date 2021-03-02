Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E017BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 10:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AA664F0A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 10:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AA664F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6116E157;
	Tue,  2 Mar 2021 10:31:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881976E157
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 10:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F82K6SEfK7xipUGUoSxjN05ez6Cm9mA40UNUvYK0ZhNF8J9qR2AVaOh6g3D56lBqEyfo3rse4HdIMMWBIHOVIcClnhOmuvKWnuRC2M23AofRIOZ5W9YRBCTDzFmCjSNDwiGIfv8R+Nd6ei3h8ZlX0rYaf6P3e0Gq2cnVg3xaH2mRI/1+kJamT5Z/YpM2KBLotdVOz6nZKqjlZZFWHIDGHoEmxSRcUbcUL8Ncm7inwV/Z3AIg0BgeT3vYzhPtqTkfr4gE6WgDlIMeUIYY55rgvQlDWUISlRnfQXI58obafB/Sv485Sxkaqk2k7pP6Kkkj++DMD2mt9Z61H84ihwUWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1S+vH2QPYLLlTL3Q2XTrA5Q4V+SciEtydcN6OzL64U=;
 b=UQqGT0hq42I1sPBRLaPbY/5vCO8AysI+TscbLclL1LIZlQ5L+0AZ2w71grv1haCH2Zo7quWK4FPZPTEKlAmVbnC3DKS0LZaAh7duhGYSdFrzoj6YpkihjG+lO8ItLPPYpJp4BU0ShaK1P8lMIGApr/x9EiZv2IrrsM/vVyvNjxAuMVw3BIfz1oVZ5zdlgrxyQd2VVteQjZ+3q9xe/CWlXRiFsxIYywtvwUPRy57tQwSCnwJVZnhibEzSkiUSH+zUs7iu+aoWgn7GK7s2BYQl+r2HbpGHPhjc32iUpk41x8DFeVv1bNTZCsrc4avamXonKmft7Vm1OW3H2hQs+dfleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1S+vH2QPYLLlTL3Q2XTrA5Q4V+SciEtydcN6OzL64U=;
 b=ob61KX9Fp3SDLKhhj05TIPSYs7aNQ5v0GX+491Gre0a/CrnKb8tgxUBsvW/i6u9dzm5w4El/xjS2MWcYbIQbfa5m755skqcCjC0v3baw0TxfcYV3NEz6B1/EiRRwtkiDtfv58HqI8njKhxeW6PMbiL023h2k9ymsHs9KvhtmTZ0=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2864.namprd12.prod.outlook.com (2603:10b6:208:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 10:31:32 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 10:31:32 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: correct the name of one function for vangogh
Thread-Topic: [PATCH] drm/amd/pm: correct the name of one function for vangogh
Thread-Index: AQHXD025+9u/guEk+02VS6DuNsQ+fqpwf74b
Date: Tue, 2 Mar 2021 10:31:32 +0000
Message-ID: <MN2PR12MB3022471A4C71A466B1F860A3A2999@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210302102018.20190-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210302102018.20190-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-02T10:31:31.743Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 190b08c4-7416-4c09-df72-08d8dd665914
x-ms-traffictypediagnostic: MN2PR12MB2864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB28648C93BABC643BDCD96275A2999@MN2PR12MB2864.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/W/MuODLSevEXF9kzqwOn0yPMkIP1HzK0P1+tFYzzDP4QR8EBkYeBkwxGErE/Mg92saKgnAEG6+vhr3Iu1XnmD+M1SZI6Tym/EEWbqkixaH5/HFeP9oD9WL0QX2tgMK9pKjMLX2oXhqIriCwwAEW+Q8aiVIbgRigPM5wR1Y0WJceQkt+9sJOsj+46ysi0xgKr4k/nyKhGyyU20tF+3/yNg09gl7KffaKv+Yh8sQOgvvk52Y5Hr0JRkqOJBfGkWaDlNmd18xuSp2KTxjlZqHqxrTqUSvnpj8Sm8zb4ebxSjv5glMnhZTlCrRRTLBos7yOdl0pChQdFdzR8knSDlAUIjdvsNc40si6nzUXK5sP2UU8jvwFHb/UgmNUU4n1F+cv7LUP05M1LAhHuoqOx2318xYBHcdEO89xFIOuf6zZP8rHrXNaJ9EhJPNy0ehW+uJFTBpa4hQBbAa3pS1J2B0aMHRBeaMlisCf4y8uJvYW2lSvNX533AGR7caa4AZxl1+CoReV7HiL5ajOuCdIpoDcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(54906003)(110136005)(55016002)(316002)(76116006)(66446008)(91956017)(66556008)(66476007)(2906002)(9686003)(64756008)(86362001)(66946007)(5660300002)(33656002)(83380400001)(6506007)(53546011)(8676002)(4326008)(71200400001)(478600001)(52536014)(19627405001)(186003)(8936002)(26005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?fH/w82w0I7MHnHYTbuUYxoOJBOTuzWTNSCnvVr6+b9QZEN28zOOtTZss1d?=
 =?iso-8859-1?Q?pDVyT3p0/7QEDY97Fr2Ei3aB8UHZFsRFVl022I3tismlyQPK+WssLH+s/5?=
 =?iso-8859-1?Q?Lu9LWgR0YKH06aiSoBlxHxXsCMDVWDMS/6W3wm/kHczPzJ7cw6G3d9tTs4?=
 =?iso-8859-1?Q?sSzmVxJ6fE8mRvNzALwhHLyyiuoHNNY+VVqckpGVZ9iQg3fSwTAtzWhCCg?=
 =?iso-8859-1?Q?6PffI6lHtUOAGqoOVCAOW/7k4rLNjEHgQclESONCreyZtuCxRskkTA2lED?=
 =?iso-8859-1?Q?Ot6JZq3Lr5NxbVhunbbILwWLRgq61lnGFGg/NVwmsZHLMhQFs/GKHGEVEA?=
 =?iso-8859-1?Q?i+GGFQXERhxQFBuvX3uf3sEsi/wvugV2fnCGhrQWeHZWU3IWHzRAdUVfYO?=
 =?iso-8859-1?Q?O0mNY7WYIoF29DQN/lG1GC1cMokE8LNFZ0zm1v6LcV0oOAyUgikr6Ij0VN?=
 =?iso-8859-1?Q?EEKPD1ETA2nFeVa0ny2pHzhKz7rXjWxFLZiOtZGV5WaLQAh5k1ZUzKFpe6?=
 =?iso-8859-1?Q?OVtqqz4k6J7yxwlJLEd6uo7sR6C2tAc9+6bMRN/cXIkKwZN0p3UPAGIPvr?=
 =?iso-8859-1?Q?X2qGk8WbPg0pLz/swArKuWFLEAbd7xTBdLSIRuoXBpcsZEaGzT6kG8ON6t?=
 =?iso-8859-1?Q?Tjal3q57fBXj7Swmpq6+B6kWsK9tmpzp2bD2QNXH4FN3Xj1MoMDuIYvex5?=
 =?iso-8859-1?Q?yVIfNcVTxDZeQATZxlH4huQ2TwsC5xNcBB92qpzpKFfhdf5rwPksKbTjEw?=
 =?iso-8859-1?Q?uVJ9WaCHeKven8fejE4TMhmxyujN+eXLfpOLC8nuhO4tXg8VIzbR8g+duH?=
 =?iso-8859-1?Q?FiE7YD7ojG1FGlMouIa8C7dj2YiMFMU/Z8dqn7kSXcdJA6PRcm812SiKEH?=
 =?iso-8859-1?Q?kHPhKOyWyg8mrsUHR9x3NZUK2U+pE/eTHS2griO/I1gUAeHNbMWJuCOA7j?=
 =?iso-8859-1?Q?BP3OpV4ie7EvomwrQhnBl6epT3dlpZmBLfMQkfsRoenef209tfb/NG7HTv?=
 =?iso-8859-1?Q?oRQq7oR6FXMMB1+A/TlPtj5e0IRkurXVdHy1NgcE7LZ000+iG+tAbx6Itk?=
 =?iso-8859-1?Q?GlkzABcmmDm4Taecl3NIbEEpY7XzZyJvlvvmT39taJ4PBnnJae34pbVPYO?=
 =?iso-8859-1?Q?zoG3rEFjKlci4r/HjUdGxzKkCEWi9kqfqLNmjcioGuexMM0jqwWrseDBYi?=
 =?iso-8859-1?Q?d4L78ex2Vm6f+u1r/MNbtF7JJAyTWv56UtFFqEu7IhHVgiQ9Nam++BiGDO?=
 =?iso-8859-1?Q?CjjfDaPVRktxi/f35DPyWD1OqCzlMMcJZiEZQ0K7rxRwAJFIq9uz6TI+rb?=
 =?iso-8859-1?Q?jtw9CGXoWXTvCl5gRRJWo4BSg55tfVyyU42FhordiusGi5b53q34E6A9Fh?=
 =?iso-8859-1?Q?nZxEhVweSK?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190b08c4-7416-4c09-df72-08d8dd665914
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 10:31:32.2378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7qmtQwystIywcCjlanVXeK5zxyaGrOzTJtHBmRxvuPmbXL51rEtxiQ2cHrv7Py2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2864
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============2050336946=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2050336946==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022471A4C71A466B1F860A3A2999MN2PR12MB3022namp_"

--_000_MN2PR12MB3022471A4C71A466B1F860A3A2999MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Tuesday, March 2, 2021 6:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang, K=
evin(Yang) <Kevin1.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Du, Xia=
ojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amd/pm: correct the name of one function for vangogh

This patch is to correct the name of one function for vangogh.
This function is used to print the clock levels of all kinds of IP
components.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3f815430e67f..2bc55de1812c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -442,7 +442,7 @@ static int vangogh_get_dpm_clk_limited(struct smu_conte=
xt *smu, enum smu_clk_typ
         return 0;
 }

-static int vangogh_print_fine_grain_clk(struct smu_context *smu,
+static int vangogh_print_clk_levels(struct smu_context *smu,
                         enum smu_clk_type clk_type, char *buf)
 {
         DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
@@ -1869,7 +1869,7 @@ static const struct pptable_funcs vangogh_ppt_funcs =
=3D {
         .interrupt_work =3D smu_v11_0_interrupt_work,
         .get_gpu_metrics =3D vangogh_get_gpu_metrics,
         .od_edit_dpm_table =3D vangogh_od_edit_dpm_table,
-       .print_clk_levels =3D vangogh_print_fine_grain_clk,
+       .print_clk_levels =3D vangogh_print_clk_levels,
         .set_default_dpm_table =3D vangogh_set_default_dpm_tables,
         .set_fine_grain_gfx_freq_parameters =3D vangogh_set_fine_grain_gfx=
_freq_parameters,
         .system_features_control =3D vangogh_system_features_control,
--
2.25.1


--_000_MN2PR12MB3022471A4C71A466B1F860A3A2999MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Du, Xiaojian &lt;Xiao=
jian.Du@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 2, 2021 6:20 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Lazar, Lijo &lt;=
Lijo.Lazar@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.Du@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: correct the name of one function for va=
ngogh</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">This patch is to correct the name of one function =
for vangogh.<br>
This function is used to print the clock levels of all kinds of IP<br>
components.<br>
<br>
Signed-off-by: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index 3f815430e67f..2bc55de1812c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -442,7 +442,7 @@ static int vangogh_get_dpm_clk_limited(struct smu_conte=
xt *smu, enum smu_clk_typ<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int vangogh_print_fine_grain_clk(struct smu_context *smu,<br>
+static int vangogh_print_clk_levels(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
smu_clk_type clk_type, char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DpmClocks_t *clk_table =3D=
 smu-&gt;smu_table.clocks_table;<br>
@@ -1869,7 +1869,7 @@ static const struct pptable_funcs vangogh_ppt_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .interrupt_work =3D smu_v1=
1_0_interrupt_work,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gpu_metrics =3D vango=
gh_get_gpu_metrics,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .od_edit_dpm_table =3D van=
gogh_od_edit_dpm_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clk_levels =3D vangogh_print_f=
ine_grain_clk,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clk_levels =3D vangogh_print_c=
lk_levels,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D=
 vangogh_set_default_dpm_tables,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fine_grain_gfx_freq_p=
arameters =3D vangogh_set_fine_grain_gfx_freq_parameters,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .system_features_control =
=3D vangogh_system_features_control,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022471A4C71A466B1F860A3A2999MN2PR12MB3022namp_--

--===============2050336946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2050336946==--
