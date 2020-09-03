Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68CFC433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD402072A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jRpG7KjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD402072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2AE6E027;
	Thu,  3 Sep 2020 15:58:08 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700086.outbound.protection.outlook.com [40.107.70.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0776E027
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 15:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AooWIZ0Y//M9HMRuxDgPoAMJfyY4cf96qICPhHBMZMT776SszO1W7L15kqVh92kmrWJMlxWVExnJSc78dSH3GZ+LNtb/ZY3iWxUntpZTQGPMUvYoyGa/t4yyxXq5zgO4RdOAk1EXObhZSJzPRyUlDE+uV0C8DL1NsEHbRaVvwc6oZAeOpo6j94Ggwd1tpZQhDhZS+bLJpCEQOQFuHphepLE7KTTPzT9gBNGRQE+O2dPOgjirjts+PSFFNvtgz2ncsRjFUyXA73ZWEtT5+gdDkCWLU9PZfDIqYp9k6/yQv+gW5M2lx+Otv7jmsJY0tMi5KRUBDDUjrW7sjx/Ph1Hpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzI4RsVyOC7bZs3SV0JTIESxM5SL6e/i6nFaHRYyLl4=;
 b=IZJDkbo7kdu2GQj7hJrmqtQTyxgjzZkT9gxcpjZJYehqE3LtM94WZDs0UuhbsGKNVMIsMsdV0FRaJi8siDm5s9CCOVi3tCOmDZyFhhqbaeik4ltLWWc25VD9V74i/mkOmu8CEZkworSdgkEll6bZaDd7SeVrQdX9t7kUD0Ydab5EYmrVe6/46YU0pzo2qSi6+lzjxLdD/FWD3Y+Y7IjXQvq7/V3ghKidiRPW9otOSiyJ0J3LdatWXgrb2o1AH4e9C85RC+kHLL6SW8Dyf5RqYcLb0CRc1nkCiZqqLZ44zdXJoJzl7DywOlFsGafcab9IkAF1PsQ3Ei50E88/ElnNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzI4RsVyOC7bZs3SV0JTIESxM5SL6e/i6nFaHRYyLl4=;
 b=jRpG7KjWlq3O/YhxBSMw3MlsZ31hYwtYb/zfiKowEmLHc7V/ayzz2zlI6rmpajAJhSqI381tExjV8pX82avxy3rQSQKn6oZDPk8ICNOQnJyb+sd3AK/fIMsja0oTaujhCSRsIf9LeSs4ybg4KRFyogjzdRSyMiEP3jCsGSPZIzQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4568.namprd12.prod.outlook.com (2603:10b6:208:260::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 15:58:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 15:58:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, Bjorn Helgaas
 <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12
Thread-Topic: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12
Thread-Index: AQHWgVjYn1VhOBXPUk2IzGwT8SswF6lV34WAgAAjj4CAABBDgIAA8EWAgAAPpl0=
Date: Thu, 3 Sep 2020 15:58:05 +0000
Message-ID: <MN2PR12MB448809E47F5A330E761C70AEF72C0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200903004153.GA277699@bjorn-Precision-5520>,
 <b44ce880-bbd9-1258-bc54-3b47d798882b@amd.com>
In-Reply-To: <b44ce880-bbd9-1258-bc54-3b47d798882b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-03T15:58:04.613Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.230.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9e25ac6-5721-4c1e-2158-08d85022251d
x-ms-traffictypediagnostic: MN2PR12MB4568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4568C7FB358556B4A9A1F3BDF72C0@MN2PR12MB4568.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4FZodZZh22Lv/Vpi7KOJCAQYsIUXYidvY0XFKyRQv32Zhd/SGriES4vUilA7r+ggOmkaMt9v5dMY42pd0hc06oQH3zP4lB1dGoGwihQ1sUbMyQ7Zhch27QBgmpTQEmdS/+rtJh0s4fgbhuqNqs/OC6qzHFDCevjIak73rhLA2gZjpK27EHaKJhBxFllZHo3LGUBZdK8P/JL37gwWjMO+swO+f0Mxkj9fG/vLTazcGGUi00UKqmE/C7qdkIFarvDuSC1YVW0splZ+bWqyvOpjUZRijR4hjn++OthJSXpGc012bLOgX2j5wyF6Q2KrDsugvVVeKlF3emij7il1BM22przNPFO4Qo1QmuHTlfp35o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(186003)(19627405001)(8676002)(8936002)(76116006)(55016002)(66476007)(66556008)(478600001)(66946007)(2906002)(64756008)(86362001)(966005)(66446008)(9686003)(7696005)(166002)(33656002)(4326008)(52536014)(53546011)(71200400001)(5660300002)(110136005)(54906003)(6506007)(83380400001)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kHoPM90m/ilmPBTec35dzxFyPPCgYCvvrGlwBiEnOA89460cY/QvIMewJ+paxll0ERjaqnlA1KeyJVaEtqYSx+Hd3f9pB56BVM82lPXd3njjyoJEs3Ekd9KaOpwpnAGaapbs2GHA0jmx7ZHrORAssTMFu/pKyX7CVwL3b7dumT9twWslOkEAAKdPAKHxrgolCngqDv+fvXG7NTV3Gm7wOWe7WIPF2s4gIsLDSFfyzS1M6uhV54vnTo9PvNSb6Lcmzuz1p2XJI1CGEkYvozwmVzLVJhhLlrL/oQPbnClRxXHZu9cxTf8PkpdCUS9j/B68Ud7y2UIw2Ft1tRKvfcCs1uHIzS8ELOcm43pKbs9YgsoMkWGJWm3QE0j8WCcf6NZxLgX2L82/VS74zv/x4wjvEmGHdVpHjEf8I+lYZHos4tlvZjy9+OkOrX7QKKTdqGbkHsludiM0+gl/yDPXmMnh2tq9R4jodR5Y51VqerzroorgHhGfTzjW7VI4Q2wM7WZOMy6+UITOa3mNKSQVuFMxHKLzhg90E4OTCq99BlYrnvEjyQMA8J522fhc4f97BuT5k0Te5px2kJPdoZ85ySZ0KRLNLC7RlLNalMZyob5UIzG3E0AmguoNGUl26HO+yZWRfnxe17LXCzO+oAexjIXUhg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e25ac6-5721-4c1e-2158-08d85022251d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 15:58:05.3317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BK3F8sAlEkjvIkKEY+/v5rE6bPz2q6foao7TpeFx53P8MKH6uGvYx/smpwFExuhPuEGg0a/SuejVBxhiyPTcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4568
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>
Content-Type: multipart/mixed; boundary="===============0191110933=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0191110933==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448809E47F5A330E761C70AEF72C0MN2PR12MB4488namp_"

--_000_MN2PR12MB448809E47F5A330E761C70AEF72C0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I'll push an updated branch shortly.

Alex
________________________________
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Sent: Thursday, September 3, 2020 11:01 AM
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; sathyana=
rayanan.kuppuswamy@linux.intel.com <sathyanarayanan.kuppuswamy@linux.intel.=
com>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; Deucher, Alexa=
nder <Alexander.Deucher@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>; Li, Den=
nis <Dennis.Li@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Tuik=
ov, Luben <Luben.Tuikov@amd.com>; bhelgaas@google.com <bhelgaas@google.com>
Subject: Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12

This one is very close -
https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Damd-staging-drm-next

Andrey

On 9/2/20 8:41 PM, Bjorn Helgaas wrote:
> On Wed, Sep 02, 2020 at 11:43:41PM +0000, Grodzovsky, Andrey wrote:
>> It's based on v5.9-rc2 but won't apply cleanly since there is a
>> significant amount of amd-staging-drm-next patches which this was
>> applied on top of.
> Is there a git branch published somewhere?  It'd be nice to be able to
> see the whole thing, including the bits that this depends on from
> amd-staging-drm-next.

--_000_MN2PR12MB448809E47F5A330E761C70AEF72C0MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
I'll push an updated branch shortly.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Grodzovsky, Andrey &l=
t;Andrey.Grodzovsky@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 3, 2020 11:01 AM<br>
<b>To:</b> Bjorn Helgaas &lt;helgaas@kernel.org&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; sathyanarayanan.kuppuswamy@linux.intel.com &lt;sathyanarayanan.kuppusw=
amy@linux.intel.com&gt;; linux-pci@vger.kernel.org &lt;linux-pci@vger.kerne=
l.org&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;
 Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&g=
t;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Tuikov, Luben &lt;L=
uben.Tuikov@amd.com&gt;; bhelgaas@google.com &lt;bhelgaas@google.com&gt;<br=
>
<b>Subject:</b> Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This one is very close - <br>
<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Damd-staging-d=
rm-next">https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Damd-staging-drm=
-next</a><br>
<br>
Andrey<br>
<br>
On 9/2/20 8:41 PM, Bjorn Helgaas wrote:<br>
&gt; On Wed, Sep 02, 2020 at 11:43:41PM +0000, Grodzovsky, Andrey wrote:<br=
>
&gt;&gt; It's based on v5.9-rc2 but won't apply cleanly since there is a<br=
>
&gt;&gt; significant amount of amd-staging-drm-next patches which this was<=
br>
&gt;&gt; applied on top of.<br>
&gt; Is there a git branch published somewhere?&nbsp; It'd be nice to be ab=
le to<br>
&gt; see the whole thing, including the bits that this depends on from<br>
&gt; amd-staging-drm-next.<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448809E47F5A330E761C70AEF72C0MN2PR12MB4488namp_--

--===============0191110933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0191110933==--
