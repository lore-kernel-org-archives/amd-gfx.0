Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6128AC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 17:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51BB113E48;
	Thu, 18 Apr 2024 17:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BxY44Y/l";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0C0113E48
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 17:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbWp6u73JJVdkehBvwZVWAosrpZUMyMl4dhSL3GSWEOpCtxlHT2SnRSpOwv6obwBbJq1YKq8yL3Io8RgZiCCSbPWvbpbXwwNL6xIB3nKTnRn4PaIrU7yJv4Q2LmL6UDbikReCo6DDkHEoB5kR8M0LawrypEV1LL3Q+IBTVNuQS8NourdNAS4YEGtGI53zsatQDUg2hi0mIFPRj35t8JjeaQ24Kk+qGOccULKUSz7y7rN6131931wgdTFsP9Tl4V9QyUDvgoLnK3P3nHtnkzz/LG1FHpYc0J21pvUW2eO9GWx/cusoKAqifPztnM8/TN2JEPAUQL63UMJjiQh/uurOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TJDJwD+2Jkz2oWtiv1x1SS3fZPOYyQg5zzeiFWEWUY=;
 b=KFuo5kvbyGZPHs9+Ou6eewAgdvaUv3SbJFBOeTInte/Jo6Jrkwc0QTjHbCfD/ewaPZczf+cHXnGYJ9DMZVvYewzUfyWPKZbQs2Ei7teazNziWPfR537/9TPxFDyVb+UhP9XmRWwsSvA8lQ26KXiaWb+WBFNt3PGfUG5QaltW4UND2nwBLDpFgJ/OS1K+z4snL7lrCleWjENb2JEW3cU3Cb2zU4JvBEpXqS75x+J2ygz0uxr9WLV0c8YG2zPDIpmyIrj9IYuqjprRum2VrqdEgAqrQ+XBY7iETBJ55i+nkDx/NTc7hx+9JlplgLo0HllaUiZiBcp2DMUgJBM2Fk5ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TJDJwD+2Jkz2oWtiv1x1SS3fZPOYyQg5zzeiFWEWUY=;
 b=BxY44Y/lYje7HTo/ZmKt5yH2s/INufuXWxYXm9HpvIQobkvmSx/4AMJkdNsUAGjaQwsb2oFYq+fxOvDV0dxYxyzkvV4+k0uDyVCrims4Y22xqhLUvM0+vCudetEWmZBbyiELZxC93w4LqL7yV7Ay1lpSDjbKC39kCTkbaeMhPfQ=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 17:23:48 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::576e:5cf0:d270:fa0a]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::576e:5cf0:d270:fa0a%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 17:23:48 +0000
From: "Ba, Gang" <Gang.Ba@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix eviction fence handling
Thread-Topic: [PATCH] drm/amdkfd: Fix eviction fence handling
Thread-Index: AQHakT7TriivMsL3p0WkcVIWUyakTbFuR9L2
Date: Thu, 18 Apr 2024 17:23:47 +0000
Message-ID: <DM8PR12MB547808C195BFDF819E05A0FDFF0E2@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20240418031410.2815452-1-felix.kuehling@amd.com>
In-Reply-To: <20240418031410.2815452-1-felix.kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-18T17:23:47.710Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5478:EE_|SN7PR12MB6743:EE_
x-ms-office365-filtering-correlation-id: 23878f67-bfe4-4032-5884-08dc5fcc4ecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLyq/aSAVYqv1FcLmj+jzO5SopVG5+rbyjM8eDgz6FrLHM9LH+9fuNRci4M4pE54X6UnpKDdZIEZ3a/KNEueIrUcFQoI3fXqp1KTgviWfidG0ZMSEfxZPpgmv6cTHePYJMdFgLEGdm4/esX03ILoa0GV9eRTkdskpJaqR2FfCtIhlxFIGm3n+L9H56c6uf2Rb+lyUjuJYFaSQ3nAS6+VmjpmzMfz5KvpfvTXwo6UMjhzPBt+PyrQqlHul3FXcaK1LO2LNJzhgp7IXMkgVZXDPjhtVbw/XhJ6hukrpaABz0SS0BCla4fs7Jfa1SJuLQ6ZYbAxYBEzzmSocnbNi3kO606AFrHdsJgMvnAL2sjFHEq6N02uB8kOWkPdbwTmKeWIVmPgOBlCi2p9tKfuHMP5EJmUCvwl5iTIPZ6zEj/Jw0xEJL76RUeRLEAw32gPhHiA7fF0Rrd0/xEQTjg2CKUah1qT+cVU4ZQYKPw5B9nl8X3hbYKtH63JtDG/jdxLeboQfRrLG7ZxHwaoSETvIbYe5g9yC7gIdjqlUjWiymu0TgP4RRIlIQ+18N7jWtCvS+pSwstRxqfIMlmtQqE6SiPJy7iYHB0rFS4XHdOs/KxZ9IIkaPAyAIDiXcXbYFWuur1dii+DfzjPTT6WRpIO0iIBhWEGG4p4dlrWTwCijvKE6XVrGVxHR2yVfFTEpKY1+rgbaBj/fePAAHe5TLM3phcAOOaV8DqM+8WGqGjQuMze9Eo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?exYWtSANF8/AaEuOzmiiUeGAJn7LWFwYrGqE0SntoJefQobQjJUaknZw289b?=
 =?us-ascii?Q?GAes4HZqHDzMdbfSEQA/86f5ShXQFdg4xlV0KeMrrFDNuojRMZn3757Ypg0L?=
 =?us-ascii?Q?T/+9luoGjRtXZDPaIHBOCgYYhGxu4totZ1w5rVm88UI4G72fYK3PiYefukyu?=
 =?us-ascii?Q?Drehpyy0RQCGAwmoyL+cJGwn3H/fbA1ONF6TAIM1ztgnkEzEXsexxMK+745d?=
 =?us-ascii?Q?LTi4V4+SAU1eitGypMH3QuPdCIFMogcMiITo7HotlvX2ifZB1BoH6vSDZt+O?=
 =?us-ascii?Q?ZtG7lARB12eoy+dM9NRpNgvX8SM6bYHQAX3KNoCxpmjVFEkFPysnspw1A4pa?=
 =?us-ascii?Q?1l6NcRtSZWsCG9ywU/XMDAwkoI6lwD9c2CPkO9F2dqWzczibUPvad1pXjScX?=
 =?us-ascii?Q?ZVEkE3+JfbQZ269y6eEwesskhwUucRS6lz9fVBwsXJ1XQohBgqN1pwiioS0R?=
 =?us-ascii?Q?K4ZyX4KdFfN2ccEj5tZrgCZYAjj3qrBlUMAtbd5ChAeYsO4Fd1mgV6tOp55O?=
 =?us-ascii?Q?GjMbeojyHtCnIkdp0ltT/A8zS71tzqK+K+tRQ1IrCQgl4qDZrAdZ5lsiuPyJ?=
 =?us-ascii?Q?seM0ujIo0cyiPBT7Bc/xstSelgRGzNTl375DnLFTKvAO3MZhYUj70wDldZ3y?=
 =?us-ascii?Q?M9MCWR+yk0+6Nj8xTe1rKAQQXf2c4sKdKoRCUi0FO7UO8hJnwAU6iTqXtyga?=
 =?us-ascii?Q?/l80VrPDMaqkzROfi0RqFScujdpqmpm6Wy1PRCevCX1te9fE50bwmmR/5V2N?=
 =?us-ascii?Q?Za26p9xu8XW9ey+culhcGV1CBQSyKqyH4gMjTkAQC73YU9NKpNkyx/26/CBk?=
 =?us-ascii?Q?bEGFgkUY+Nko+31YCwPF+6xTHALIoFxwg5BUFjoxONTmJyodK/D4Z/fuuDni?=
 =?us-ascii?Q?dm9aiMwJTsOoOFDJ5SgNHwEvZ42KKCOg1Xa/RlE/L6g+VO9sKsctWwBh5XQJ?=
 =?us-ascii?Q?/HiwpIri4v3fbDk6SsjQ7t+gzA8XC2DECWOg0fb4Dm5Qp6cgwMwZ//YMpT/m?=
 =?us-ascii?Q?J1IJd73uMHlU4FyRhi/PHYMIpbkcdLUcgusJ6V3/z4PFmJgXfsWZlbQo4Tvu?=
 =?us-ascii?Q?hKqsZb0/Xof080FvsasXyiQ2bCNceHAPeRtOkaxQcdhT2zxA4gnsf8hLspZr?=
 =?us-ascii?Q?P0FoW3rYjPUGd5irQo2L4aTh0SyBwrYhujCIhy4IZuWmRpHdBMtSoT95FKiV?=
 =?us-ascii?Q?bYQ/OOwS+7Yk/wkWVNU6WKR4moTxLcjhuSrWV70/auD4m5Lirik4CgslTWIP?=
 =?us-ascii?Q?a/0DqT5++xijKvzZqToX34zZcF1kQaFn3jfEV4WE0Ean1sZ5DxcSqfP/UR07?=
 =?us-ascii?Q?OK00GYbtY7hCUl/8KRx3gqIV0moUHfrOi6l9Nky0qqsPOv/DHdAU1UCgZUTx?=
 =?us-ascii?Q?rTK26dgKaLBoKj56U+ZQ1Lxpe26Zm7jtKUGRwx3KCzuAvjwJf76E3IRzYoeO?=
 =?us-ascii?Q?Z7xRlvVTng12PuL0cObAiPVBm8z20Ig/dMp9hnfnjIh0CrBBMJh7ii74m0H1?=
 =?us-ascii?Q?aVficlBkJjtKw4rrLkI6rSOFZN4ak+AfItHDBHs5+eW+/EpMdh2X4M4bdJ41?=
 =?us-ascii?Q?Ch3pnzAAsgsvdBJtwdU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR12MB547808C195BFDF819E05A0FDFF0E2DM8PR12MB5478namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23878f67-bfe4-4032-5884-08dc5fcc4ecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 17:23:47.9682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1+5upwqmAOr9EqVKb9eGmhxBtCu4rkffV5XPsTIvumcA2gNcUKgXSMpeAJoJI58
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
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

--_000_DM8PR12MB547808C195BFDF819E05A0FDFF0E2DM8PR12MB5478namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Tested-by: Gang BA <Gang.Ba@amd.com>
Reviewed-by: Gang BA <Gang.Ba@amd.com>
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, April 17, 2024 11:14 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Ba, Gang <Gang.Ba@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
Subject: [PATCH] drm/amdkfd: Fix eviction fence handling

Handle case that dma_fence_get_rcu_safe returns NULL.

If restore work is already scheduled, only update its timer. The same
work item cannot be queued twice, so undo the extra queue eviction.

Fixes: 9a1c1339abf9 ("drm/amdkfd: Run restore_workers on freezable WQs")
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index b79986412cd8..aafdf064651f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1922,6 +1922,8 @@ static int signal_eviction_fence(struct kfd_process *=
p)
         rcu_read_lock();
         ef =3D dma_fence_get_rcu_safe(&p->ef);
         rcu_read_unlock();
+       if (!ef)
+               return -EINVAL;

         ret =3D dma_fence_signal(ef);
         dma_fence_put(ef);
@@ -1949,10 +1951,9 @@ static void evict_process_worker(struct work_struct =
*work)
                  * they are responsible stopping the queues and scheduling
                  * the restore work.
                  */
-               if (!signal_eviction_fence(p))
-                       queue_delayed_work(kfd_restore_wq, &p->restore_work=
,
-                               msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
-               else
+               if (signal_eviction_fence(p) ||
+                   mod_delayed_work(kfd_restore_wq, &p->restore_work,
+                                    msecs_to_jiffies(PROCESS_RESTORE_TIME_=
MS)))
                         kfd_process_restore_queues(p);

                 pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
--
2.34.1


--_000_DM8PR12MB547808C195BFDF819E05A0FDFF0E2DM8PR12MB5478namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Tested-by: Gang BA &lt;Gang.Ba@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Gang BA &lt;Gang.Ba@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 17, 2024 11:14 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Ba, Gang &lt;Gang.Ba@amd.com&gt;; Prosyak, Vitaly &lt;Vitaly.Pro=
syak@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Fix eviction fence handling</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Handle case that dma_fence_get_rcu_safe returns NU=
LL.<br>
<br>
If restore work is already scheduled, only update its timer. The same<br>
work item cannot be queued twice, so undo the extra queue eviction.<br>
<br>
Fixes: 9a1c1339abf9 (&quot;drm/amdkfd: Run restore_workers on freezable WQs=
&quot;)<br>
Signed-off-by: Felix Kuehling &lt;felix.kuehling@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c | 9 +++++----<br>
&nbsp;1 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index b79986412cd8..aafdf064651f 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1922,6 +1922,8 @@ static int signal_eviction_fence(struct kfd_process *=
p)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rcu_read_lock();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ef =3D dma_fence_get_rcu_s=
afe(&amp;p-&gt;ef);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rcu_read_unlock();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ef)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D dma_fence_signal(e=
f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(ef);<br>
@@ -1949,10 +1951,9 @@ static void evict_process_worker(struct work_struct =
*work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * they are responsible stopping the queues and =
scheduling<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * the restore work.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!signal_eviction_fence(p))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_delayed_wo=
rk(kfd_restore_wq, &amp;p-&gt;restore_work,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (signal_eviction_fence(p) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mod_delayed_work(kfd_restore_wq, &amp;p-=
&gt;restore_work,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiff=
ies(PROCESS_RESTORE_TIME_MS)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_p=
rocess_restore_queues(p);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Finished evicting pasid 0x%x\n&quot;, =
p-&gt;pasid);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM8PR12MB547808C195BFDF819E05A0FDFF0E2DM8PR12MB5478namp_--
