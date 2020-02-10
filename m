Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55984C352A3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 14:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA80520714
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 14:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OdMz1t82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA80520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941546E99F;
	Mon, 10 Feb 2020 14:10:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DBC6E99F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 14:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVJCdbgIbrDRD1LVvc/mxSWrpnhLEByNdsu61A5P63fmQjHNOjGfbUbAEBlP86hg4eUTQ9wigVcfCgBoj7/scujreFfh2UpXphnf3QDGfeunGZ4L7gKiQcz2fuzNUP3DfxE15HqMkmkXckcEuKEklj/lT9n5wAFw5TVpLj4dIe2WntX9fScA5b9oiPdu6Vg1TpxHz192RvApOwVGVmSvWMxEliUA+0/oo+Z9FxxOZtLtwnUzGtvGTzJsdKbL9xrlx/q6p+NixGmoc4VvFDtVYP9b/oPoVFa6awtlR2hnhwBfX5gBfLlWSaDvnPYv36VWmzIolV9IR8LfsiCW5ZxmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYa3CIXY8RRc61XyZltc46zxiZfDy/k/4141DPZ0X9Y=;
 b=mC9s0Tgj27sZtI+FAnqwdLgKU3GdX6Z4S9AzDE/HHR1F1MwyUZEmFowK5bbKH7woHIPXuCu4SJR1mVip2Aok2nzp1q8ycr2Hyoud6SeOJ0wFECXskUsfiTg2cXnXx1ID6H16PP8FY0vWVFVgIGovqZpcGb9lj6uvbpcIESVn1VXRXqmik8PO2bcZfdMAuqGeips01G4c9KKaek8BVBL0k77YFrv6pIOGHv2fTXZvcbBxlYhQkfl3bBm6hCAo782n3iilpebYQCoI9CBNCQ2mjRppmnkW6rzm6tLVVkH9SADumNyZ+FgFkr45NgErvstwcFhmQfhdmh53y/vYMMZReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYa3CIXY8RRc61XyZltc46zxiZfDy/k/4141DPZ0X9Y=;
 b=OdMz1t82EGbzL7pv3ZibtLX/fLlyMpVKmj+d3i1s7/FGr6a3I91WQdsaqsL3BGJ5giUW00RJO4x1Z7QK+HHxarf6KPIcSIdjSP7qphpEHB4TPYV73CmDkKC6e1nPac6bsemJ2eAf9GkcSBqX0mkEzRYTL1O57NQaL++gz1LZGag=
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3445.namprd12.prod.outlook.com (20.178.196.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 14:10:17 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 14:10:17 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn2.5: fix warning
Thread-Topic: [PATCH] drm/amdgpu/vcn2.5: fix warning
Thread-Index: AQHV3bj2ZHORA9OAx0mEUw079iJ/7agUfB8b
Date: Mon, 10 Feb 2020 14:10:17 +0000
Message-ID: <BYAPR12MB3285B7435D5BE31460937B30E4190@BYAPR12MB3285.namprd12.prod.outlook.com>
References: <1581081447-1508-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1581081447-1508-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-10T14:10:16.971Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40faebe7-7c40-4c09-1397-08d7ae32f4d1
x-ms-traffictypediagnostic: BYAPR12MB3445:
x-microsoft-antispam-prvs: <BYAPR12MB3445BD0B63358DCE6B849568E4190@BYAPR12MB3445.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(8936002)(7696005)(478600001)(53546011)(186003)(6506007)(2906002)(6916009)(8676002)(81166006)(81156014)(316002)(26005)(86362001)(55016002)(5660300002)(71200400001)(9686003)(64756008)(66446008)(66476007)(66556008)(66946007)(19627405001)(33656002)(52536014)(76116006)(91956017);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3445;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wc7n68i8eijPHSVU6+LzUhMnWZ5DOID5Dzudxi/cdWmf8OGlLz2CKhVPudbOUG+37zQJRhNv7DuurEpZyLAPUU/ZNLBbKQwLkw4ApsM5WnXMdpIpf/VYBJCGbGSinBqiB8G5ujxLdcR/sFPKYqNL3ioxxPCfSzaijNpu55JuIrVIgsNurPjFdpgN2sV6kRU1eAM6B+yUiFR0jlRpNo2WIeBTxS5wKQboE2V5X45xvW4cNo45FifjwgGDtrVHnLuArGlbVScAhf4F58yH8xVYJMYgwWjfTI8tQe7OaSA0HRRdRizibiD7QDI+QKg3WojGE6mjT5wP5KmMffYZM6KVk7ygS4owqOph7IXTPJqin2aWdLoiKWC2ZgsmN22xfVBzGdn9ZcOQjjvw/5JRmrqLaSyxiamtHoU8isPS0FI/RblQk7SGFg2hnpPZpt7tAiJF
x-ms-exchange-antispam-messagedata: PphyA/CGpac+BJRw7AegYkJERFkPXjcTSOwTdU2qvIWlNML+WMEra+MRAb5ouBLYd5mAHy341uQiLAO3i9qRpa2C26JEtw19F57kbQRdVJZaguAjF13+UyLLG1GBoN2E3tAdzjmr0tW0VcD5y5vSSQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40faebe7-7c40-4c09-1397-08d7ae32f4d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 14:10:17.3376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWd+FCyskkMHwHGrSlRAJZKy2ZCuL3zMfhApYXJ6rsnoPEl67EP0ZyY3h9jhh8Q8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3445
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
Content-Type: multipart/mixed; boundary="===============0405839837=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0405839837==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB3285B7435D5BE31460937B30E4190BYAPR12MB3285namp_"

--_000_BYAPR12MB3285B7435D5BE31460937B30E4190BYAPR12MB3285namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

ping


________________________________
From: Zhu, James <James.Zhu@amd.com>
Sent: Friday, February 7, 2020 8:17 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhu, James <James.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu/vcn2.5: fix warning

Fix warning during switching to dpg pause mode for
VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 16

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.c
index 97ab44c..2d64ba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1407,7 +1407,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_devi=
ce *adev,
                                            RREG32_SOC15(UVD, inst_idx, mmU=
VD_SCRATCH2) & 0x7FFFFFFF);

                                 SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_PO=
WER_STATUS,
-                                          0x0, UVD_POWER_STATUS__UVD_POWER=
_STATUS_MASK, ret_code);
+                                          UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_=
ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
                         }
                 } else {
                         /* unpause dpg, no need to wait */
--
2.7.4


--_000_BYAPR12MB3285B7435D5BE31460937B30E4190BYAPR12MB3285namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
ping<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Zhu, James &lt;Jame=
s.Zhu@amd.com&gt;<br>
<b>Sent:</b> Friday, February 7, 2020 8:17 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhu, James &lt;James.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/vcn2.5: fix warning</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Fix warning during switching to dpg pause mode for=
<br>
VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 16<br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.c<br>
index 97ab44c..2d64ba1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
@@ -1407,7 &#43;1407,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH=
2) &amp; 0x7FFFFFFF);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(UVD, inst_idx=
, mmUVD_POWER_STATUS,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x0, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_co=
de);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_ST=
ATUS__UVD_POWER_STATUS_MASK, ret_code);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* un=
pause dpg, no need to wait */<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB3285B7435D5BE31460937B30E4190BYAPR12MB3285namp_--

--===============0405839837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0405839837==--
