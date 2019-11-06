Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7687AC5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 15:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4B8217F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 15:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4B8217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 034246ED93;
	Wed,  6 Nov 2019 15:05:21 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800085.outbound.protection.outlook.com [40.107.80.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FBE6ED93
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 15:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYxBk5RiccZi4pn9EvWnthMclo7OR/v9eOAQBLNHJEYd7qblXQ5NMJpTzvLAhxg1hfhurJ/iMGciNVNGJS21fU3gzetemiT6Pi4jF8Jq5oVYlHoTUllrc0I+f9mdvi60sdil1h8fT5SHEcK5IS1RwcoGHZ2Axnj2Dvux4t+WqbAOwwQBOVDrcihymvc/Nw1aIxZiVJJn4K+E1jjLNQ/uDRnLsh2YjQY5sXeupXO36Uy2QMp3DBJyr4GpsF6pzJlCUtleqzDFUzOeo+1/SLlt9n0TKvgHCwuEvV8yYWIBMkvB0njzWVUgtGdAojH8EAmtkXlTBSnD3la5jteR/P+ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnqLrXQ6YoAvyuptoOO+z5otHh8vAtvkWizYunp91+Y=;
 b=Ez3FQWa+Wl0fWn9R4y3wiK71jE8bu1z2pjcCe0YwWfVs+MrBV01ch/WQOtkeZYHYSUJQNWthLAKJY7vW8Haouu/YG/UAbbbdLqPqvBhezxZR6mY/cihEcd43Kbi7J9GPExtjnKuAGYmkrmlxkUGYyn/jXcj1zToRP/WW1d6E7S4oXg1C0X2FRt33fUr9psS4I4gErlqJVhFJuwIEslhs7NCYcM/qYcrec1KBRerjEJiTBxrkfzPJl23GCq+w1c6NKTYiNx/9YkSCvl20JHWY3pfy4Tq68nndLjoW0iK3tbjPWWEc9xVgbS4GTwGGY9e0BoR5SF/czF3ii4Du+SRoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1813.namprd12.prod.outlook.com (10.175.80.21) by
 CY4PR12MB1544.namprd12.prod.outlook.com (10.172.68.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Wed, 6 Nov 2019 15:05:16 +0000
Received: from CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc]) by CY4PR12MB1813.namprd12.prod.outlook.com
 ([fe80::dc23:193b:9619:a4fc%4]) with mapi id 15.20.2408.025; Wed, 6 Nov 2019
 15:05:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Thread-Topic: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Thread-Index: AQHVlGrE42DO3ap4CkyKrim635Z4O6d9rgMAgAAzLoCAAApwAIAAUqtt
Date: Wed, 6 Nov 2019 15:05:16 +0000
Message-ID:
 <CY4PR12MB18131729CB48513830561F76F7790@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <1573021419-15518-1-git-send-email-Emily.Deng@amd.com>
 <MN2PR12MB2975A3DFE6CCED7BB3D6D2748F790@MN2PR12MB2975.namprd12.prod.outlook.com>
 <6be1e7b9-13a9-f382-ef66-00c284a14a14@gmail.com>,
 <MN2PR12MB297565CEDAAF6460C71F98F28F790@MN2PR12MB2975.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB297565CEDAAF6460C71F98F28F790@MN2PR12MB2975.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bdf4f42-da8c-4970-f4b5-08d762cabba9
x-ms-traffictypediagnostic: CY4PR12MB1544:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB15442B6A27B8A7247C9D6038F7790@CY4PR12MB1544.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(13464003)(53754006)(199004)(189003)(606006)(236005)(99286004)(966005)(66446008)(66556008)(66476007)(64756008)(9686003)(6246003)(26005)(14444005)(256004)(33656002)(2501003)(6116002)(76116006)(3846002)(6306002)(7696005)(2906002)(19627405001)(54896002)(110136005)(66946007)(66066001)(76176011)(55016002)(66574012)(7736002)(5660300002)(74316002)(6506007)(53546011)(8936002)(52536014)(446003)(476003)(8676002)(316002)(6436002)(81166006)(81156014)(25786009)(11346002)(102836004)(229853002)(486006)(14454004)(105004)(478600001)(186003)(86362001)(71200400001)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1544;
 H:CY4PR12MB1813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRlEfqr03QnGOWY+mEWU2hTAFVy1GXYauQOKk5EdMnwOwLIQS5oDLDUlCL3v5JUYDEW3mpVG++SKunSoRM5JGnFXlJJ7zP0kkzCzmq1FtS90aV4w+bQ33h9dcHhF8U3/uhv4Y3Df6Y/c+Sw3soZp7Bw/w+MdrGJzQVjhKyiMSRhDPoil5fP24uzFGM07o+gsqeFCyNivR+4ZVNW+0RJ0OPtkX2hmVci82UjNJ0lUl906gcYlp9Tk9gs6zULIHLmHSrOcfsyhSCBYawr8AbN3P9JDtimnP9lmtNqMNVCzCrvceUQfu1mfW2uqJ4v/l4tm+wBVBlK8MtsSyaEXQ/sQrjvUxbZ4OFDKkd2tYPvlXVTmcHKBEnjLPGFDdobmqp/KT7/weAd+i/LjQlld9d+FHpF3dVTrwBuFH8Fkc+YxBT9RU7nw6b5+USbfSrCXX0Jtyg04b2+lzVmapi/Ruwqx+g8d6MVBOi26wZEu10+EPkY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdf4f42-da8c-4970-f4b5-08d762cabba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 15:05:16.6338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4n5bGFw9BxLM3imHkGhlE7S8CdnGZqi+a46jzgjOL8HulbX9Gt20zIRjHTQNALanE71fA2ZNy06Em2cGo9rIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1544
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnqLrXQ6YoAvyuptoOO+z5otHh8vAtvkWizYunp91+Y=;
 b=g0SnQ5rfucyO6cK1KS3Rjzcgk5f0JHnpsVlAr+oOfa/D5hlyotA5/Ka/+GnJqlQKiDEya+MRp6U/Dvo9avfrph7dQOqMPFJAg6RLLb9oCJcgKPB+d2kDXWcwCk61VKVAy0cxTHhx6FeLUWKOJa4OuakvsvbbKZVehHgWLBADfOw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0872663815=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106150516.1vqfuLos4n1pYGGT4EttcWMX-LclqNeyOSSaekrn-cA@z>

--===============0872663815==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB18131729CB48513830561F76F7790CY4PR12MB1813namp_"

--_000_CY4PR12MB18131729CB48513830561F76F7790CY4PR12MB1813namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Deng, Emily <Emily.Deng@amd.com>
Sent: Wednesday, November 6, 2019 5:09 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Need to disable msix when unloading driver

Hi Christian,
    We use " pci_alloc_irq_vectors " in amdgpu_irq_init. This patch use " p=
ci_free_irq_vectors " in amdgpu_irq_fini.

Hi Alex,
    Could you help to review this?

Best wishes
Emily Deng



>-----Original Message-----
>From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>Sent: Wednesday, November 6, 2019 5:32 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH] drm/amdgpu: Need to disable msix when unloading
>driver
>
>Not an expert on the PCI IRQ stuff, but from what I know that looks correc=
t to
>me.
>
>Only question I can see is why don't we use pci_alloc_irq_vectors()?
>Alex probably needs to take a look.
>
>Regards,
>Christian.
>
>Am 06.11.19 um 07:28 schrieb Deng, Emily:
>> Hi all,
>>      Please help to review this. This is to fix driver reload issue.
>>
>> Best wishes
>> Emily Deng
>>
>>
>>> -----Original Message-----
>>> From: Emily Deng <Emily.Deng@amd.com>
>>> Sent: Wednesday, November 6, 2019 2:24 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>> Subject: [PATCH] drm/amdgpu: Need to disable msix when unloading
>>> driver
>>>
>>> For driver reload test, it will report "can't enable MSI (MSI-X already
>enabled)".
>>>
>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>> ---
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> index 6f3b03f..30d540d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> @@ -311,7 +311,7 @@ void amdgpu_irq_fini(struct amdgpu_device *adev)
>>>              drm_irq_uninstall(adev->ddev);
>>>              adev->irq.installed =3D false;
>>>              if (adev->irq.msi_enabled)
>>> -                   pci_disable_msi(adev->pdev);
>>> +                   pci_free_irq_vectors(adev->pdev);
>>>              if (!amdgpu_device_has_dc_support(adev))
>>>                      flush_work(&adev->hotplug_work);
>>>      }
>>> --
>>> 2.7.4
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_CY4PR12MB18131729CB48513830561F76F7790CY4PR12MB1813namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deng, Emily &lt;Emily=
.Deng@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 6, 2019 5:09 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Need to disable msix when unloading=
 driver</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Christian,<br>
&nbsp;&nbsp;&nbsp; We use &quot; pci_alloc_irq_vectors &quot; in amdgpu_irq=
_init. This patch use &quot; pci_free_irq_vectors &quot; in amdgpu_irq_fini=
.<br>
<br>
Hi Alex,<br>
&nbsp;&nbsp;&nbsp; Could you help to review this?<br>
<br>
Best wishes<br>
Emily Deng<br>
<br>
<br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
&gt;Sent: Wednesday, November 6, 2019 5:32 PM<br>
&gt;To: Deng, Emily &lt;Emily.Deng@amd.com&gt;; amd-gfx@lists.freedesktop.o=
rg<br>
&gt;Subject: Re: [PATCH] drm/amdgpu: Need to disable msix when unloading<br=
>
&gt;driver<br>
&gt;<br>
&gt;Not an expert on the PCI IRQ stuff, but from what I know that looks cor=
rect to<br>
&gt;me.<br>
&gt;<br>
&gt;Only question I can see is why don't we use pci_alloc_irq_vectors()?<br=
>
&gt;Alex probably needs to take a look.<br>
&gt;<br>
&gt;Regards,<br>
&gt;Christian.<br>
&gt;<br>
&gt;Am 06.11.19 um 07:28 schrieb Deng, Emily:<br>
&gt;&gt; Hi all,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Please help to review this. This is =
to fix driver reload issue.<br>
&gt;&gt;<br>
&gt;&gt; Best wishes<br>
&gt;&gt; Emily Deng<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt; From: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
&gt;&gt;&gt; Sent: Wednesday, November 6, 2019 2:24 PM<br>
&gt;&gt;&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt;&gt;&gt; Cc: Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
&gt;&gt;&gt; Subject: [PATCH] drm/amdgpu: Need to disable msix when unloadi=
ng<br>
&gt;&gt;&gt; driver<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For driver reload test, it will report &quot;can't enable MSI =
(MSI-X already<br>
&gt;enabled)&quot;.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 &#43;-<br>
&gt;&gt;&gt; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt;&gt; index 6f3b03f..30d540d 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&gt;&gt; @@ -311,7 &#43;311,7 @@ void amdgpu_irq_fini(struct amdgpu_dev=
ice *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; drm_irq_uninstall(adev-&gt;ddev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;irq.installed =3D false;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (adev-&gt;irq.msi_enabled)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_disable_msi(adev-&gt;pd=
ev);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_free_irq_vectors(ad=
ev-&gt;pdev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!amdgpu_device_has_dc_support(adev))<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_work(=
&amp;adev-&gt;hotplug_work);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.7.4<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB18131729CB48513830561F76F7790CY4PR12MB1813namp_--

--===============0872663815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0872663815==--
