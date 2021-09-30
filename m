Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B07C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FCE61A0B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6FCE61A0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C6B6E402;
	Thu, 30 Sep 2021 14:48:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB306E402
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 14:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aURi50pzz9Cv+acbWyVwyZeEI/CPbv3lK8ej943XjswTooFWU+8rNFlX5veZ3b/fh5O967tpVLnrANjGxHGXEt0a9Y30pGBtIPUS0O+TFE6weSN4vag8KQD0Wo8k/fyU1WwOiJv/ZFiNh5rfrT3Qfb9t6c8X5mfub6RtBo5B6yCs02QpSRuUxqHl7PwSdNNd+EjCcAu1VR+I+DnhoAFuwtu6nOjlE0VX/6BoDUlqjvQRKZUOtfSPoFCLwswqBmfDOl7Dc24fQq2LxUFvI9ToF7WQwahcRn2/pKwNwCwm79oHnC27NkvlDYAES8V8qCLGiCDpqeJF7TVBhI0JcQC7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UH2IALHfuM8FuOvfR0PazLnqXFOqiEMEGv7iaHXjK8M=;
 b=cJTnTzwKq4YCohRcFleXLRyh3jyZnEeZUpWSozAHJVnUCtF7gzxCe1ItDfaPZeFUJ8+DIbVKLFonDhTGWsNjFFz/mX+rJe4mYX78IYNc1kyRbvwjlsoN8Jju8HuicjRBf6G2AvrUKl4f0Fv886U+iiF+kkTzYIpXua0K0JljhsMiw6pDHFFNnZMb5lEl/9YNUcrk2Y3RS484Xmnv0u+o/1nPNco5Gk4lTNskrhhS6+FgLoJRd39G2KYA8Wdq2PBZ4Bb3dAJ2lxXNghAtxWdQ80AcEUM7uiE7gHFwIVhFq7AqrZuFr6KTnODXio5Lf1FDyvdVpit2XOwmuVXvR/WKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH2IALHfuM8FuOvfR0PazLnqXFOqiEMEGv7iaHXjK8M=;
 b=KCaywF63zQaw4b7+TsUDcMfCM1+i/JSyWJuZ0F/BtPC8rS14tV70gpfWdo1R80MwUI8ItpXYN/I74l6uHSREqf1LJnPTde1dss2WdFGktePoxsjorSSwx7IxE1vkmjgDd3lOZsX7z1A+HW6aY6i9SCG3cjapAz6467z+2MmukJw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 14:48:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 14:48:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: print warning and taint kernel if lockup
 timeout is disabled
Thread-Topic: [PATCH] drm/amdgpu: print warning and taint kernel if lockup
 timeout is disabled
Thread-Index: AQHXteH48BxLwetld0+VEY+Slc2C/6u8qJDn
Date: Thu, 30 Sep 2021 14:48:13 +0000
Message-ID: <BL1PR12MB5144DCFC89873C4DC8C0077FF7AA9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210930100014.1337-1-christian.koenig@amd.com>
In-Reply-To: <20210930100014.1337-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-30T14:48:13.217Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 5cfec394-2548-2782-1aec-c4ce23ba80b7
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5696fbe-14e9-4b32-0fa2-08d984215492
x-ms-traffictypediagnostic: BL1PR12MB5159:
x-microsoft-antispam-prvs: <BL1PR12MB5159DEA426F7FAF2F4D84A41F7AA9@BL1PR12MB5159.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gB8f8EPMYMaKdt2o7pNE4hZr5tFQIgb35XCA/ih/Y/ath3wci7vGd79+9X0nfE1Emo6iUmaQoIUw5RFNnpC4SQIh/MQ9oULMmzwXUYRd0ZQoyukE1jA9Cws15TfDUC+uZ8wc3cE2vZPTEJ/iZ4ll6M2QyzOomGnyGf/cOR77Pac59B8rsHzGwWQ1bl5FnwDd2GODjra8Et+sxklG+eogvXU+05h6Z9fEoCMzth+Bp2rjzy+VyoSrJ0UZPs47F/Iek0bl0oQawAJmYjMglhx84WKBE2Yn3IeIIFBS3dkFDBcg879o49bI8hxh5MU2Di6zMJ6LONplIx/xtNsLMb+0pR2xukhgVRqD/Rk3Aqizz6TuPLnqMdHSlWxchxMNk8wNDjGgonOxVDur00HikCwgF13TCe7HJM2aak7sRua4WiAxkpfy18WgqXnEzAp8PZT83Q37tYmYaW8OdKB5NL1y2LQR3mJNfWLSlNpHrfykb0G9rWD5OfQ4KQGf4teBouLu7xBm5CN9ODgLmeFjJ0CxdgJ0thBibg05tUTPqFU9bI4n9C4ly0UzvbUDVp9/IY3XqwFS8qZ7uMXmRUNBFyJ9WEH1sL2bpyzGcrEmu1rJy6QwkV94q+k9PIAHyhtbQc5clT8BMhYx+6eHJAhvHsd4fdpYRSgrbju69INEMqjSHTaLWbre/caIoozRLmpQ39+HKDhoi4XguVJEMcGgHPQUSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(6506007)(66574015)(26005)(76116006)(66476007)(66556008)(64756008)(66446008)(53546011)(7696005)(66946007)(38070700005)(110136005)(55016002)(71200400001)(316002)(19627405001)(2906002)(5660300002)(122000001)(83380400001)(52536014)(33656002)(8676002)(508600001)(186003)(86362001)(9686003)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r6SOHm6A0WfyivjRkCJgPZlSkbdtx6XQWBeYN6zIGoseM/3giD3jcMl39T?=
 =?iso-8859-1?Q?7moDxRitWsiy8TktkQBpAmq7OnP01D3tZgsmgmkdXv0Aszka6gn+xptiDf?=
 =?iso-8859-1?Q?slRZNF7laxxSKdmA1K/XcO0U1KgnC1WU5vrwef3TCmrpC5w4HZLD8OqE0v?=
 =?iso-8859-1?Q?ZoktpVZJ+omRKv1NX09uwmRX38uEUjWn0G/56HKYfZ6WOsQCMYsytxQOFp?=
 =?iso-8859-1?Q?54q1698Mkdy0jS1jFLWBFsjXGuMxFsVH1aC13xG0RAWxCvEzrHWUl+oEQn?=
 =?iso-8859-1?Q?J/MyH0BHT1KDshkmLLr5V2yyHFb89UCdo6z8SL36+if8gmWjOWtodq2a3z?=
 =?iso-8859-1?Q?WuSkjhEJ0txCAeKlCNlZJzyowZl8SeviVXKDQmh4I5ruIXiYH6vMxl0oZF?=
 =?iso-8859-1?Q?TI3F9dqYoR2PkCRmDksQfOcHQ0J1K39cPKbHp0JEFUUN2u9l496xuXHvvc?=
 =?iso-8859-1?Q?0cWS3XAZeTxhtKOzxWU+gRPVchD9EVlr7wFkqhY33udQ09J2GYhyYKTHuV?=
 =?iso-8859-1?Q?Z0roLfqQuoPHPSQ5wM6YOMSBaLpoakcTdlvS3OOM3zetuIbQsWq4fTu5rO?=
 =?iso-8859-1?Q?sfIGTaf6CQIpZ2oRKtD0F2Mw7Ee2/x4KN1h3RyK1cBgNRIrxU8mwAOCyST?=
 =?iso-8859-1?Q?+xxQPORKfpVAIfFjuM0OJR+cGWq8q0qsgVc/i+IeYATwSj+fLqRYe5YGIx?=
 =?iso-8859-1?Q?P2tCws87QTIrXyilH38676pJ84YAbZGm8pCwUxiQwM6wVURLSmcxIU+Ua5?=
 =?iso-8859-1?Q?+gb4ZqMQVpDFtKP4ok84fTICVh3x7hoMjeZnVD33TGkakWrRhkhBHbN0fx?=
 =?iso-8859-1?Q?73IdDhsmXuILpcGsUTErEGCvduC/mrbGbLFyIfvYzrKdEq3HlHgHHPJ7Lg?=
 =?iso-8859-1?Q?yMuelUZgDfRyhBEbJMr813jJlokhfRVHoM5zebDNBGFCmU/h3XxbYsY0kD?=
 =?iso-8859-1?Q?cViLSohs7b6Xqr0cMvHnTbBPdk6KE6jIO6k9c0GoS4qV3IkzsH+amOwrFe?=
 =?iso-8859-1?Q?EKZ3HKFnKFT+nxpBQeqJo5ER877hRex5+Iv9E3ylLyf2iBTmNlVHZ1nGzf?=
 =?iso-8859-1?Q?r1MiSMKxY9417sW0V0IcIeSdkohcOdjTIZmbXu3D4fYIo3B8u9epolfAND?=
 =?iso-8859-1?Q?iq6kXF6nxU8ybJ3QKUG2ouTPkTF3ts2QfVA5Q930Yw6JJW9/fo3DU3zN/R?=
 =?iso-8859-1?Q?v4WGKpv6Q70vKrJwWjSbkKUn8CQvjydn7pYWJNbh/uEZsskl8zIKrCiZZ9?=
 =?iso-8859-1?Q?4JIdscGZeu/OQ6Eehm1uaGE6waq1Amf6eual/+dXBjaKvoX3g+w67MOgBO?=
 =?iso-8859-1?Q?NowFE9yGWMgoNL76u7CQ5huOlpYdA8SqSKLLKPQBsdmUjLdH0AvBeSd/25?=
 =?iso-8859-1?Q?ywBbVfpWMj?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DCFC89873C4DC8C0077FF7AA9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5696fbe-14e9-4b32-0fa2-08d984215492
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 14:48:13.6265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPapXyIsfZepTtytBERDxr9sOcX/vyHTHFktqRd3AHMG+iqSxDkQPvD45m36R6rQGJnWAR8F7vTGXdgoYKjurw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144DCFC89873C4DC8C0077FF7AA9BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Thursday, September 30, 2021 6:00 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: print warning and taint kernel if lockup timeo=
ut is disabled

Make sure that we notice this in error reports.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 4d34b2da8582..8ee5bbc19f62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3346,6 +3346,8 @@ static int amdgpu_device_get_job_timeout_settings(str=
uct amdgpu_device *adev)
                                 continue;
                         } else if (timeout < 0) {
                                 timeout =3D MAX_SCHEDULE_TIMEOUT;
+                               dev_warn(adev->dev, "lockup timeout disable=
d");
+                               add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_O=
K);
                         } else {
                                 timeout =3D msecs_to_jiffies(timeout);
                         }
--
2.25.1


--_000_BL1PR12MB5144DCFC89873C4DC8C0077FF7AA9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Thursday, September 30, 2021 6:00 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: print warning and taint kernel if locku=
p timeout is disabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Make sure that we notice this in error reports.<br=
>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 4d34b2da8582..8ee5bbc19f62 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3346,6 +3346,8 @@ static int amdgpu_device_get_job_timeout_settings(str=
uct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e if (timeout &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_SCHEDULE_TIMEOUT=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;lockup timeout=
 disabled&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_O=
K);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D msecs_to_jiffies(tim=
eout);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DCFC89873C4DC8C0077FF7AA9BL1PR12MB5144namp_--
