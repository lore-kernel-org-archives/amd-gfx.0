Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F722C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 21:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FE8610A2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 21:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FE8610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E185389B96;
	Tue, 15 Jun 2021 21:40:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1BC89B96
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 21:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQ4G1OaBcuHwklqOKm/ZdnHhrSizP/LvtUwC2JHghcqFR8up1jZPNdGY2nTrIurpdlTucnHb1+FNPznnYmLWtG5Kuj4lD4BQm0qrP2zINeIIy6ZSVYoiXY+eji/XXfFSa5kxi5zy6jEKMISK76KPM5+0JYbavGoDkJFRe/2OhW7dE02nHIVT6tZXxcLbQ8bevL415SF0bj+/CAROlj1I4nhaEanIvmUQgFmRury3CP2dqBXBiiCj0VT813tYcUQsfNKjqxicXTZHBrwZdU7/Dfm/Zw7oMPzhfPzW0HpJu3naYrko4AMhm/XgRPHOnB0oEE/1RVvyz9iPpiOgHbUfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLuwR3K9559MqScyTetpx3/XLL4iXEW3QBNLU4+Ei5Y=;
 b=jer8s7pfy5k5ym20lbf7RkSQJg8hvBMhkPDjrpc+AUtKl/IS9eZjoxYKIZNwdufN4Z/sCPCkAc55nJDyvxuVAkBqmK0LPZaDVgCrRi/nh6+aSvJrND/gdRzrVezfXOzgcyB32D1oK5agZ/Delf8CR2OwJMmTiT/DNGvixOolVZ+3zD7rBSBeZ5eRYdkr/lQkeUla+HGCt7nCjx/uGuLzY5mcJZMQFLkhah2EiYmnJWC3uEVSrD2W9zWkbq8gIJPBQKobuKhGyHuOD8Oq5cT1NXmEmFyvu/wDY9KFLFt1a5Xb56nl5Py1edjsa64HGgaLbeaqMeK+5nbZrB/q77eycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLuwR3K9559MqScyTetpx3/XLL4iXEW3QBNLU4+Ei5Y=;
 b=NJdHbry32gTyle8thcaqLBt7PfZErCOvgWYXqLmAcmM2hVqmSGN8uVxq/R6p8zI5CaUgLgFZS3leS1wvdLF27OsPNKl/6aEqhWxypX2vPKfWU4cLimyEecMBTQm9sVTjt2345b7xLz/WyYoNFVFIYTGExnrN9NaA21yY0qUiwwg=
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.29; Tue, 15 Jun 2021 21:40:52 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4195.024; Tue, 15 Jun 2021
 21:40:52 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn3: drop extraneous Beige Goby hunk
Thread-Topic: [PATCH] drm/amdgpu/vcn3: drop extraneous Beige Goby hunk
Thread-Index: AQHXYi5EWe4M5vgTi0uJXuTJQ1g+i6sVmdgf
Date: Tue, 15 Jun 2021 21:40:52 +0000
Message-ID: <DM5PR12MB251775FB939585566EDF6BB9E4309@DM5PR12MB2517.namprd12.prod.outlook.com>
References: <20210615213259.1326051-1-alexander.deucher@amd.com>
In-Reply-To: <20210615213259.1326051-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-15T21:40:51.748Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f7003f4-8314-4e39-54d5-08d930463fb5
x-ms-traffictypediagnostic: DM5PR12MB2471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2471106F63D7F0245A732EB0E4309@DM5PR12MB2471.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k1tz5WNM5fLD1d21YfTisv0m3nVpK0pMqXrn9elPilqL780LfSSLrT9chwe8sQzVLb4D/Hx9z/s26Km96Ei42v1vqZzeKDNZILNd0xXSr0eStm9n11yPEAd127kHCzDzp1iKtQhDOH9k86K+fiMnkwaKGOoThPWjY6HhCCsvL4dHVlJeYbesNk6rqQid5zjhGNRBD4EJ2H5u0AyD93wGK6eqkiXGfWAl5RnXdWqN1BlZu8WMxrYZ+ZaAlzyQ+jwcdf/F3P1YjKJG4HGKCO4j1LXeLUY7lPbOCNivzNKHLoLqxulESK+/BnGtEd1qYKeRQWG/TpmoImkRJTFNr/JurH/Oa9XiKnF87sf8dLhCjtKAOQ3FDehFOcgoZhXV7mDORF/9y5qskrbjKEeWJMVBYOhhrRH78CaJazFe7EWrQmYokEwxm8d+9lG8Ep6rYBZYfJGDs1/TLATra7NpUU+Xp5/6Ko6HbO8CWRJWiPjJdFwcdfl3VFrxPyGkR/GKoOUSLE+xlJq2ZMcRovcGsUFGAO4MIuGRzf3Iw3JYMnRsjUgBhKpyScH7tR1pyOViJn1Eudm9JEs2Nu5n217x3fduEgZ0ygMvqTv8COMdVsZx2HbL+3wp0sXUh5OeIEZkiY2l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(53546011)(26005)(52536014)(5660300002)(8676002)(45080400002)(71200400001)(19627405001)(7696005)(33656002)(64756008)(83380400001)(9686003)(186003)(66946007)(66556008)(122000001)(2906002)(91956017)(166002)(110136005)(76116006)(316002)(478600001)(966005)(55016002)(8936002)(6506007)(66476007)(38100700002)(86362001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zG3xx8+T+cP/rL2j9Blab/gxsHFjvEjLaxS1cBkTc6MBN2HZVl8m/CkB7FoL?=
 =?us-ascii?Q?Wb9yycUUsB7biywzXfr8mH+LSgDIiC9S4DNBd53iHyHtu8Dz+XTMe8lLjO0l?=
 =?us-ascii?Q?yGkXkbmVgRruKuW1vBX9Lcq8hNs3t1JexlcODSjK6Fk7cybnMPTkFXsTmK1l?=
 =?us-ascii?Q?5npzxxauRrHrrs8uV5WuXpYluD20PoVzeW1N3mAtocasOH3vAhbldoqUkXD2?=
 =?us-ascii?Q?ADXuXN2pWimMqF4qprDvpxFKQgoFW/2kgP61Jcg2GMUwKXxc8nu/Pnx1Qn6L?=
 =?us-ascii?Q?GJOVEwvSUvVCYe/ymVB5HLDS7TvhLcR1jx3CmAK77mmPYP8MedUxJEl/+wez?=
 =?us-ascii?Q?t9kP7I41J39HCVzbqLZXZ0tVWRBxLqldI8iqTxHXuDVWfPsWwIQvNfR/N4bl?=
 =?us-ascii?Q?nwu47TG2WBtO/d7im/+Ev3UXlGtsXPPiSV/nN0kbjeEw2KJYJpqZJU1RzasG?=
 =?us-ascii?Q?fWMhRLKedx81btqd4D5nFT0/DyDDFIOCPKUM1NWE4itimd4cQSgAj+TgOwIb?=
 =?us-ascii?Q?4wGs1dVf+x6D5tdyDk/+uc/zI5LxDotWD/E5hupXlqMcoTwEtJgvV+jO/Msw?=
 =?us-ascii?Q?76f/6ibaBHkVpqrD9A8/UHG1n7YcslI5GUFNUcHNvMEYG7j8nYF1YhVgaBOO?=
 =?us-ascii?Q?l9HUKcUNwNLVWSJ1eQUyvojKkhFL/OgJda8UPIGalRIjZlt4kFBqpn/RqzAI?=
 =?us-ascii?Q?EEEBmoBG/ALAbwBQz0NnKR1uBACMhQ3VBQapi8By4s0E12IjPQ59+DF8eY6A?=
 =?us-ascii?Q?LQsiTK+LT4ilm7rXInp6kgoZjlKVr7ePmHoF0WZHaKVXBEjLT867lWxSsLyZ?=
 =?us-ascii?Q?V7m3yxzEQM4J4ucSRmryVK3hOZfaWWULmp6ANV/xneTkpnfrbC+FDA0gQm6Q?=
 =?us-ascii?Q?j6p9/iZqHxl2qHVVoFfQgjCQ3u1rFQ1rZFYxQos3m5iMEXmQxUAN6ueiHEDK?=
 =?us-ascii?Q?UD6B6JsQpwuAhAya6SznOyhPanTQ5aZiSY9gWENTTwlVsP02Zu5wrkBDKRS1?=
 =?us-ascii?Q?B4Q1YqRhTpSwb7yhRkYsrRuTpTxd6yHW4xYi/0R3z6H9f5VE91yLlstBm2FN?=
 =?us-ascii?Q?CGeZy1Zk20PBjAgsUpPm42CGdqVPDNavOjglq4oXc+PrmBhY6x115NtzYDPD?=
 =?us-ascii?Q?CH+1XXmwQQYFacDjn+SoZmNNOX9KbTyeamry9puJpnfV+h5Imc60Fx+pWdtZ?=
 =?us-ascii?Q?RBvF5Ah9OP6eKg85T6SDHU/dFdC3eNl4KeteNJmYM3K9NRqVDA0LvJ+MKOnk?=
 =?us-ascii?Q?sEyFqDOJqhp1+3vTuL6wCPu2Xcpp7nlls/Z93HhXfvYxhl6ow1P6MjK7lb6M?=
 =?us-ascii?Q?20Y=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7003f4-8314-4e39-54d5-08d930463fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 21:40:52.2909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Af1l0zpMJFPfwTHQDyNUn3oNHKGxIUu9yGfbR4sJe8W6cYbKwGpVeZScF/JEtKdA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2471
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
Content-Type: multipart/mixed; boundary="===============1012743592=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1012743592==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB251775FB939585566EDF6BB9E4309DM5PR12MB2517namp_"

--_000_DM5PR12MB251775FB939585566EDF6BB9E4309DM5PR12MB2517namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>


Thanks & Best Regards!


James Zhu

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Tuesday, June 15, 2021 5:32 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn3: drop extraneous Beige Goby hunk

Probably a rebase leftover.  This doesn't apply to SR-IOV, and
the non-SR-IOV code below it already handles this properly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index 4c36fc5c9738..ea6487ca997a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -93,11 +93,6 @@ static int vcn_v3_0_early_init(void *handle)
                 adev->vcn.harvest_config =3D 0;
                 adev->vcn.num_enc_rings =3D 1;

-       if (adev->asic_type =3D=3D CHIP_BEIGE_GOBY) {
-               adev->vcn.num_vcn_inst =3D 1;
-               adev->vcn.num_enc_rings =3D 0;
-       }
-
         } else {
                 if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID) {
                         u32 harvest;
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cjames.zh=
u%40amd.com%7C438470def59345ef4f1f08d9304565a2%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637593896894033208%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DrTKU=
aT%2BRjI0S%2B8le%2BdbtSUGjksyDTF%2BV9SdBTwFpjxk%3D&amp;reserved=3D0

--_000_DM5PR12MB251775FB939585566EDF6BB9E4309DM5PR12MB2517namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
This<span style=3D"color:#c0c0c0"> </span>patch<span style=3D"color:#c0c0c0=
"> </span>
is<span style=3D"color:#c0c0c0"> </span>Reviewed-by:<span style=3D"color:#c=
0c0c0"> </span>
James<span style=3D"color:#c0c0c0"> </span>Zhu<span style=3D"color:#c0c0c0"=
> </span>&lt;James.Zhu@amd.com&gt;<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Thanks &amp; Best Regards=
!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 15, 2021 5:32 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/vcn3: drop extraneous Beige Goby hunk</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Probably a rebase leftover.&nbsp; This doesn't app=
ly to SR-IOV, and<br>
the non-SR-IOV code below it already handles this properly.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 5 -----<br>
&nbsp;1 file changed, 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index 4c36fc5c9738..ea6487ca997a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -93,11 +93,6 @@ static int vcn_v3_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.harvest_config =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.num_enc_rings =3D 1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_BE=
IGE_GOBY) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;vcn.num_vcn_inst =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;vcn.num_enc_rings =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 h=
arvest;<br>
-- <br>
2.31.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cjames.zhu%40amd.com%7C438470def59345ef4f1f08d9304565a2%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637593896894033208%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a=
mp;amp;sdata=3DrTKUaT%2BRjI0S%2B8le%2BdbtSUGjksyDTF%2BV9SdBTwFpjxk%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cjames.zhu%40amd.com%7C438470def59345ef4f1f08d9304565a2%7C3dd89=
61fe4884e608e11a82d994e183d%7C0%7C0%7C637593896894033208%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;amp;sdata=3DrTKUaT%2BRjI0S%2B8le%2BdbtSUGjksyDTF%2BV9SdBTwFpjxk%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB251775FB939585566EDF6BB9E4309DM5PR12MB2517namp_--

--===============1012743592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1012743592==--
