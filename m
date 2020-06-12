Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4927BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 11:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194092065C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 11:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Em5HnC2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194092065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41456E91B;
	Fri, 12 Jun 2020 11:04:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DE76E91B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 11:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYOIBa2wd8dN1Yrq06tS8MtMhh4YZDKODrh2hZ+QXT2MsEXTwMtAPzJtG1eHcMH6CPgHf4/sAf3CREKWRft/VoWi88WhaYPZbqF1m5xS+BPB7yP3Y/xa6IjDA9jvDufhKs27GNlpSwxh0YnDvbyVIhoFOFW7WiFN3uPJ0OVQUkL4ZgceEL2bprrV5Ug+ApENCNr22RPYM6RULwlBjhvsMwVRfsyKhPu+h8QyqPzvO/lUIH3vURlv1t3tmeQ1Lw2gNxPgw6pVKh9hV564+k79squNUzM9lNp1GrPCxlACEH3Txe7/xipewRoyKXBrTQmr4tU3PZzsItSvtZ1fnWDgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPou+Fu6ZXaJXVn9XiJRG7RelnMJAr/XHnNet+LuVFQ=;
 b=n8H0R9FNGJUkMhA6uAWqc3kv4lKCW5B1qZLee0cNiFZKOGPYuw5tehS7SI7DCaVwSiP1fhe5Yh333EnW3KOCnDPS1K4XKlej9bjBcl0wwG+SchqccbK9ip3Ug/DH0L3ddvCLfKGkFNDQQxl9p3u87PO39gRwdwYDVOI3la79+Grr5G92GR2hV+CFR6Yw5DHOIODii0w42vHrwKcX3o92qHtTCMuZkAFM4CC/Iv/0cnVyyLnXO07BZxWVaDVI+yTsjWmK9NdK9MMSjem/LKv7+XXCc+p0OKXR//eChSLKrYqNeohsB2P5axzXsO0xYPzpq3I2wipc/6FsLsxNuMcPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPou+Fu6ZXaJXVn9XiJRG7RelnMJAr/XHnNet+LuVFQ=;
 b=Em5HnC2uqD7Z6dyZA3GnzZdPn8+7qljBhEgq+6ocnmj/cZ6RqvoSN/7h/0Vo8eNk5JQRbARCQR1t3JMzlDB5x9wGHIDNO0xphCe1W+fs486keKBQ2CPns1+saZnVqk1qgKhU1RlbraX662MhyRsGQNmcuMS68BH9gzC1MwBSuhs=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3085.namprd12.prod.outlook.com (2603:10b6:208:c5::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Fri, 12 Jun
 2020 11:04:25 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3066.023; Fri, 12 Jun 2020
 11:04:25 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: remove perf level dpm in one-VF
Thread-Topic: [PATCH] drm/amdgpu: remove perf level dpm in one-VF
Thread-Index: AQHWQJxJdpkVaD5VXkCN8E94az0fN6jU0P86
Date: Fri, 12 Jun 2020 11:04:25 +0000
Message-ID: <MN2PR12MB3022A7FD07D068626D3EE2C5A2810@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200612093034.19799-1-Wenhui.Sheng@amd.com>
In-Reply-To: <20200612093034.19799-1-Wenhui.Sheng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-12T11:04:26.504Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86ca4b35-c8ee-43fd-e478-08d80ec05e90
x-ms-traffictypediagnostic: MN2PR12MB3085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB308569BBBB53809D24C8E3CDA2810@MN2PR12MB3085.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EnlvfPyRd6Hzh3/5EOAyq2/Rb+upVLmexa1rdnyCTtHSxLlM67GWkYm065BAlrABBzYAdMNENePdBysaYNPnq/sAyWgCq69SGw7Im5FWGwTTv6/Bst6nv7F6ZN/N4s+raXMdZ2WFCJPTr0PjZcbN9jFUFQZJKgH88tUpo2Kpg7IpFodnQhhGbMDjnWnLwTEB582agNX0gOWI0+Qzl3jOz+rgHEzjCcyZM0RwwZpQC6BlhDmQ/fG8pTuqIzfllzQM8dDuRoJPSo6Wl3Ak09ftQ7G2FwMIfTEvkUT9muGcHbSXUSlV0Py2jxL/+d6OutztVnJeOxesng/cjfKO5IC2QLk/sTcfvxncDQAMm+Hhfjg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(186003)(45080400002)(86362001)(9686003)(2906002)(33656002)(55016002)(166002)(8676002)(26005)(478600001)(966005)(110136005)(19627405001)(8936002)(5660300002)(76116006)(53546011)(316002)(6506007)(66446008)(52536014)(7696005)(64756008)(66476007)(66556008)(83380400001)(71200400001)(66946007)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 2so5zMRQ+rEEVuL+urpHaL90FmfPunqmRENMMry9mY+nDL5KFon/3n70BEpueXJJbNvv5iZps8aH1/5rAkA/lgL11wfPIy/Od4YyiWN7kG/efTUjYvhBoa7CaFbhLZBgqZbK2pqBjlGJQoQ8fbcybCAmnNwSHJXZvlRyUXF94dxs4zyzMa5LwwE3vwka/kqSn9kbeTFg81beTIZ/YOzC5TvpecxBfcbR9TpHWr9PMVbOcUFEcmkweIc5lqeG5pnHKEqOeJsEV8RHRIrpj73PKaGdVUv+d/O2shooz8ukCQehFG10XWJNCF+qTOFnS1T5NKTqczJM9A6kkS+pScJJDmZL62FSeAm4fNPTvw8xiJhTpHZvUx9J8wArmFNksc7QKKCWIx5hvwnIb8+tbkBB6SUyOFQdZUMpsJkGNPZPXxmE8O/ApqMPt5JKmEkaRwaG0PkUoM+n9FNWIJda23mYL500btH5uTmNqlPHBWGDTZSaCG+nJ9H075Kdn78FJP4j
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ca4b35-c8ee-43fd-e478-08d80ec05e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 11:04:25.4749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ga7Pi+6HJzEYPmQ8Nczad1rPBmoyat/3kPgUd5KU9t6LXbhEilNWjIy5HbIHvQ1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3085
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
Content-Type: multipart/mixed; boundary="===============1300570303=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1300570303==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022A7FD07D068626D3EE2C5A2810MN2PR12MB3022namp_"

--_000_MN2PR12MB3022A7FD07D068626D3EE2C5A2810MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

which smu message will break this node work on navi12 asic?

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Wenhui S=
heng <Wenhui.Sheng@amd.com>
Sent: Friday, June 12, 2020 5:30 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com>
Subject: [PATCH] drm/amdgpu: remove perf level dpm in one-VF

On Navi12 platform, node power_dpm_force_performance_level
doesn't work correctly in one-VF mode.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 395ddbe2461c..4e7b579afe0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1877,7 +1877,7 @@ static ssize_t amdgpu_set_thermal_throttling_logging(=
struct device *dev,

 static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
         AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          AT=
TR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             AT=
TR_FLAG_BASIC),
         AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           AT=
TR_FLAG_BASIC),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7C76d3cddef9744f5c7ee908d80eb3502e%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637275511045991505&amp;sdata=3D1uvfK9R%2FMAFkZrgPk5aEnVM=
Qs9zYOJQUFdLWwLzMbs4%3D&amp;reserved=3D0

--_000_MN2PR12MB3022A7FD07D068626D3EE2C5A2810MN2PR12MB3022namp_
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
which smu message will break this node work on navi12 asic?</div>
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
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Wenhui Sheng &lt;Wenhui.Sheng=
@amd.com&gt;<br>
<b>Sent:</b> Friday, June 12, 2020 5:30 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;Wenhui.Sheng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: remove perf level dpm in one-VF</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Navi12 platform, node power_dpm_force_performan=
ce_level<br>
doesn't work correctly in one-VF mode.<br>
<br>
Signed-off-by: Wenhui Sheng &lt;Wenhui.Sheng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 395ddbe2461c..4e7b579afe0b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1877,7 &#43;1877,7 @@ static ssize_t amdgpu_set_thermal_throttling_logg=
ing(struct device *dev,<br>
&nbsp;<br>
&nbsp;static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(powe=
r_dpm_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_force=
_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BAS=
IC|ATTR_FLAG_ONEVF),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(power_dpm_f=
orce_performance_level,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG=
_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_n=
um_states,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RO(pp_c=
ur_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DEVICE_ATTR_RW(pp_f=
orce_state,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ATTR_FLAG_BASIC),<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7C76d3cddef9744f5c7ee908d80eb3502e%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637275511045991505&amp;amp;sdata=3D1uvfK9=
R%2FMAFkZrgPk5aEnVMQs9zYOJQUFdLWwLzMbs4%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40=
amd.com%7C76d3cddef9744f5c7ee908d80eb3502e%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637275511045991505&amp;amp;sdata=3D1uvfK9R%2FMAFkZrgPk5aEnVMQs=
9zYOJQUFdLWwLzMbs4%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022A7FD07D068626D3EE2C5A2810MN2PR12MB3022namp_--

--===============1300570303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1300570303==--
