Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF2F36B97
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 01:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E36610E8AD;
	Fri, 10 Apr 2026 01:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QifUYj5C";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2634C10E8AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 01:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpIxBEXgd8yi9uuq6Yh3Y5kAVq0cI8XASvm1cLevUI081K6wLiDC/BKE9l8u7vPQz50izMVzn5gP2sDBHe7XH/QM4l5chXCnE5PwM9KN+stgFKWKVGyudnmi1Uu6qjCvVq0FOJfu5rsDegErv7T/PxcZwKlgJ1cbjiojGZSAsqQ0+a1HomplaIACvMEXwPwtK0MHhf2omoQDBCDzuo9UlJzSTaMT3EhKV4HD8rS1smRzS2ysBzdi8NEAySVA1NzCa/5G4vmVPAAbEVhPZkXVGQWdcyI1Q1wmb7sYZCCcODDkQyUiC6/wdQTKFO3dS+9h9/C46/HJTWxriTmYgvNH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPJPj+sMJ7XQA1ycDWeBZtwHt83q0hVlOkPn4jU1NVY=;
 b=kV7UeCc03PJBi9v0WyiynkLZ3y7O1rBXWc/cGSR+elfh2Np1UYzQQEEm8dCyk6OmZHQumgJ7NTqCgsTctt3gHKSivd5DHMfWLsTh0lFOaeErTNrJ3fyYtY2AIBxzyrt0BLrnd8IOrWTPPNpcAc2sJYN28NNczYH3sQeXDyVtwvqGORRL7wUro0ElIBUx7y+2yDmxifGGzYdV7qmxcuxbU3eK11QsySLtsFf1o0Ovjrx5Tpgin75jHynaNWMPIpbtza3TGzKS6xLK9ratrunsZD2Sc0eeomC8JbOtILtXiJGggWc6mxWDXbK+8UNg2Cc4HlXkkiHtwXA8fELI2yUsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPJPj+sMJ7XQA1ycDWeBZtwHt83q0hVlOkPn4jU1NVY=;
 b=QifUYj5CYGEvL6PDFv0IeVnnnCOm+N3rgKLbPtNfKwdH0tTXEOjoYNNF3QBU7w6yjEDfY/JpbFwViB4o5Gs2Ifw8DplJIKQksaKNL1iJ1x7Ac0vlUaVXw1YtiEmKnw8ZuvDSb//UPIphq149RBLey7yKpOIQNzEy1sghaUb0FXU=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 01:25:06 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e%7]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 01:25:05 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: correct single device PCIe reset flow for DPC
 status
Thread-Topic: [PATCH] drm/amdgpu: correct single device PCIe reset flow for
 DPC status
Thread-Index: AQHcxxphvd65o3MB10i5FpgQh3rOxbXXgys4
Date: Fri, 10 Apr 2026 01:25:05 +0000
Message-ID: <SJ0PR12MB69671EE0AE9DF08BA2F5851A9D592@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20260408054126.2202627-1-cesun102@amd.com>
In-Reply-To: <20260408054126.2202627-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-10T01:25:04.381Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|DS7PR12MB8347:EE_
x-ms-office365-filtering-correlation-id: 162975de-a79d-4561-7b85-08de969ffee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: nXt7ccqucR3VuI5r3ZDVuzxFT13biyA8pt8ZXAtNxkfSHiOEO0a8ndzP7GHNxaZ/HoMYo3r18UYtuXO6Gr/6UiOSvS4aLfKovVNad/SqK9ZuLwqbmhWXf/e7S3VXg/i+GICnLU3nudeMJARceM+9vxBhc5kzV0qSVvXdv9w1fd1i+XvIVFyYHpu3xm9ZiuFBp+Eu/4gMfapNOvoFIpfY1olrNxiBNkgu43CF9VbiQ84een6rB5fMEDwMrXDI8hNZ9xC1XoNyi3b3EpE9hP7CnsMfgQ6+zyPnU2CeIIFXeA13cTrgtOg/WbYVeDYZhnMsq545acWDAWkxR3llxtCmfOqw4g5/poVi+tQ8sM8ZQq1D/bK8QlK2UULtTc5a7b7qItnba7daRV9mhhFZCUVTjVzmyO5Q+DXyG18h3/rpvYhKPTIxzFo3f/2zG2a86e5EqPXLR//dBKqoInCI44fZJPlePEYb34Vsvn0qUtX5H1RFCXS3CD6j5IAILeAqq3oAMc25E6yn5GCzjUpw/uEPvj0wAV9LeZvg3tES4q3TExgfv9Ov4tAbMPCrlQnDDpcNQjQ8eWDAawF9dbEgWLXpTTJoBQvFX5GgKRdHZPKBzMVyAO1cNdRNohzrIi/e12cdCDS33P7aRsXYmrtHKpMsMeZYtWN0YRgW3FvFjQqBv8l8PXhpL4H9LPT0jSfB5hfK8AVotEQ3xGjNNBDLjDI4NmT03XwKcOAmcyZvjIQa44SQVJFBzFkN26RItujCcqAPshoNqwC167MgOGxF69flo3krXCueBsTzZ13tioJoMrI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qB5nokfS5A9b3HFPCPsrBWtxY3BhX0dt3lTwDhQ6h2PObuwkJ5xITUApBss1?=
 =?us-ascii?Q?ukH9Fd0imPqdHWpGgde2zFB5c/AiYQd0FikQoVddwGMBG46J2iR8djbZnE4T?=
 =?us-ascii?Q?2QVm2UlbwqZJ+eaLrMNCBrgmbngyKQrgTvAu2yWHZu/t1X+LIs6K3mqgCZlM?=
 =?us-ascii?Q?qy19njS5qOcvDKzAO1KVe0j2yUdKN9hbYeucYxqpApvSHw3vZqlfqZk64nke?=
 =?us-ascii?Q?ZI8QQUIR1BYys/qi8aR/CXcRruI/xEKFACcg6SX8b9JhrnvquY0560xG76qu?=
 =?us-ascii?Q?c9Pz/HvRSvxVMc+yiH9t4+Vnz1Hx8AZhL6OFJfSGpG5vD1emfPzo7OXWPd5t?=
 =?us-ascii?Q?XErq09t4uhtW//xNyeiiGzGb840og1hwf9GEH125VI9vRBNVO9bSEurBWRX9?=
 =?us-ascii?Q?ujEjU3eZX1ETJkNZnplYOLww3Hq4pSfaMx+hDP7fqI0icbjduSsYwPy/rKVv?=
 =?us-ascii?Q?oXh25eUlxCWyUKqOsXJysEyV7t0whYifcJ++c5CrOLnJOX6D/nBGKt47KMlK?=
 =?us-ascii?Q?oOsZtrj9UQZ7oLDXcUdz+taQEqgCIt2M0TomxaxV/oQhBccLALssGGLu+YyQ?=
 =?us-ascii?Q?/lFQ9SvcyT2/UcC1E59YAGGHGF5qoF6muWJ3qX1rL7U4rj2fqFQqLSlPwBmz?=
 =?us-ascii?Q?Dgt6YWsXPPJjOq5LmUXm7w+Z804Pu+L5xVegf+s4icz9enCPsLx6BcniK03U?=
 =?us-ascii?Q?wOgZlXm5pUDxrcivzXZk/s/CjzpG7LkJM1/FD2a8FvKDxxMQ4LDz9g+L22zT?=
 =?us-ascii?Q?dmET2yy5eSBJFarOSDk0GaOCwN0Di//ViYZ9YZFw8NdDTqw0bhd+qxBL02HC?=
 =?us-ascii?Q?0Gdx36WF9dOBwwOHGAn+NmVCV/DLol0fqF+5uV1wqZQZvvob5kHv8l3xtguc?=
 =?us-ascii?Q?5xRWFa9/onzyIjABMyUd7SJaSh3EJP6pwBkyUr3Zqh3RuAh6DEeBfNk1cYPc?=
 =?us-ascii?Q?+bnB+Y2jK7UbZLxJVct0YYRoFfRaxNyFKyARxFlRmzvQbfR6R9ZeVjBJa0L5?=
 =?us-ascii?Q?2u7mJ5XVlBJKto+7OKFodESRtq19euqtEZ1QNIpKRzVdt8lwnv4vBxci6sHQ?=
 =?us-ascii?Q?brbx5d8BjnokgCVtKCMI3a1dU9aIYUbqGu+pmaCWJ1Cqzn8zZ4SfpMugj/Od?=
 =?us-ascii?Q?orgLgoJKnw/h9xuDrzqh98L7r8XQHpLIz1rSosOM1sj8Qb+gnMH4ay75i5sw?=
 =?us-ascii?Q?x9qFmhnRxXOjWY/zmveAQ+g2rCa5sbqeiZsIsJVyNH7+fqNpqk2zpzomxCIr?=
 =?us-ascii?Q?bZNScTgXbpVWqxB5f5QgA6n5deGGuu/TngO42SnIfo55hLnnVRDepbJXX+tY?=
 =?us-ascii?Q?GP2LzUE5zt9MBVpOP+qdoYJbY4Vs5MiR7Qwk9QFiyEl9VorR/DlossIQkMU4?=
 =?us-ascii?Q?NHUfl7Xw9aYuh78WQNWCa2ayrZ13z00YgkvqJQaPPBXdH+8RlQiQOVZxG0QJ?=
 =?us-ascii?Q?1tcRB0y6rw2dTm4NDTrlfyurdihY5eBSx3zyg49vNWtdUIzvz0Cah21uOab+?=
 =?us-ascii?Q?lLtfOGw/8T5PjbFLGA8IOtDBY+UytsYtOv25M+yK/nd8hP1HYmWRdIzQxxFD?=
 =?us-ascii?Q?SOZaDQxzwEGcz8jFfT6WUCjzkDxJtl7GFds6qOQ1lTxUP/IrGvzq2UkqAySz?=
 =?us-ascii?Q?cf7OpKoMURaniQl8Q1ybdluPdM+zakxYI/2xq7fi1AFS3H8BTKuULiB//XRz?=
 =?us-ascii?Q?9qcecjHq/0n/YOjUoHnyUFdBKwIINKFZzI2IswrF4MsbOT+U?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB69671EE0AE9DF08BA2F5851A9D592SJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162975de-a79d-4561-7b85-08de969ffee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 01:25:05.2938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boiOmt/46WoWVxwneWzSvnhMFro1938h0x5GghCZxhl8ErJtezETEP6fdOh/Xw1am/zesKISHKQHzzu9Jyz45Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
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

--_000_SJ0PR12MB69671EE0AE9DF08BA2F5851A9D592SJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

ping
________________________________
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Wednesday, April 8, 2026 1:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>
Subject: [PATCH] drm/amdgpu: correct single device PCIe reset flow for DPC =
status

For triggering the dpc event with a single device, we still need
to set the in_link_reset flag and the dpc status.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index deb41c095b59..0bdb54ab9a53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6291,6 +6291,9 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci=
_dev *pdev, pci_channel_sta
                         amdgpu_reset_set_dpc_status(adev, true);

                         mutex_lock(&hive->hive_lock);
+               } else {
+                       if (amdgpu_device_bus_status_check(adev))
+                               amdgpu_reset_set_dpc_status(adev, true);
                 }
                 memset(&reset_context, 0, sizeof(reset_context));
                 INIT_LIST_HEAD(&device_list);
@@ -6411,6 +6414,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev=
 *pdev)
                 list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi=
.head)
                         tmp_adev->pcie_reset_ctx.in_link_reset =3D true;
         } else {
+               adev->pcie_reset_ctx.in_link_reset =3D true;
                 set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
         }

@@ -6467,8 +6471,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
                         tmp_adev->pcie_reset_ctx.in_link_reset =3D false;
                         list_add_tail(&tmp_adev->reset_list, &device_list)=
;
                 }
-       } else
+       } else {
+               adev->pcie_reset_ctx.in_link_reset =3D false;
                 list_add_tail(&adev->reset_list, &device_list);
+       }

         amdgpu_device_sched_resume(&device_list, NULL, NULL);
         amdgpu_device_gpu_resume(adev, &device_list, false);
--
2.34.1


--_000_SJ0PR12MB69671EE0AE9DF08BA2F5851A9D592SJ0PR12MB6967namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
ping</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sun, Ce(Overlord) &lt=
;Ce.Sun@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 8, 2026 1:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Sun, Ce(Overlord) =
&lt;Ce.Sun@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: correct single device PCIe reset flow f=
or DPC status</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For triggering the dpc event with a single device,=
 we still need<br>
to set the in_link_reset flag and the dpc status.<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-<br>
&nbsp;1 file changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index deb41c095b59..0bdb54ab9a53 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -6291,6 +6291,9 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci=
_dev *pdev, pci_channel_sta<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_reset_set_dpc_status(adev, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex=
_lock(&amp;hive-&gt;hive_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_devic=
e_bus_status_check(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_set_dpc_status(adev, true);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(&amp;reset_context, 0, sizeof(reset_context));=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_list);<br>
@@ -6411,6 +6414,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev=
 *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_li=
st, gmc.xgmi.head)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_a=
dev-&gt;pcie_reset_ctx.in_link_reset =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pcie_reset_ctx.in_link_reset =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_SKIP_HW_RESET, &amp;reset_context.flag=
s);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -6467,8 +6471,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_a=
dev-&gt;pcie_reset_ctx.in_link_reset =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
add_tail(&amp;tmp_adev-&gt;reset_list, &amp;device_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pcie_reset_ctx.in_link_reset =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;adev-&gt;reset_list, &amp;device_l=
ist);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_sched_resume=
(&amp;device_list, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_resume(a=
dev, &amp;device_list, false);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR12MB69671EE0AE9DF08BA2F5851A9D592SJ0PR12MB6967namp_--
