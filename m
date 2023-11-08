Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A99C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 14:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA6610E797;
	Wed,  8 Nov 2023 14:57:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4309710E791
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 14:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/wCL1+5cMKYO+PSDoP1rRWs9y6EFrcv4sg0Z7FWQlNoLjcpax7fho/sVcyWFTQkQT8+nO6vzruSdIJ9eLYLRL9oPTM01YIfw9gVcT7E+PaKS0GP2F0Lphg8GFfnRsCbGZAHTZUgOSElUBH4naXfS3YQ7jH9u+rF1jx5ltEPUEQbPhvx8HpVoRHs/E7GdrV+W1pkw4ZNDtfBEiQQjIiKkJWasg2AXzEn1Vfk+Gm8D+54BjyppkWozhzhBegreHal3jYqXrWiz0pa07J6Vdtc6OzOWg3mGk96v7eSNiLJqVuSpMPqkNt3iQTDDgGac0tv6wKblhCId67SJczm0LoGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgkWK9PImB8FFJUPGClp+YQSmI2PFnSn4FVKUwh2uaI=;
 b=HbVaRccupZtTnlSKuCKLyPoqSvaiCI95PEefH1DXyn9sfcLdNJw6lLXeZoKJ41wO+SYDHd9ooLlX2t7R1RNbaafmsxtte3ZzmoH30z0fxie5EuawLkYorPq7CvSbhOzHFt8WSYW73ZNlhZruqaH67JKOJfh7zOS4lYYmgnoz1tkLv12WZZaM4gRMIoe8Ngdso7pw9mF6YpHpgEEyqNXYnLE7e5ezhWZU2WaKHTz7+QB9wXMJ3CzTavdYVRREt6OL9f3ou/YPCOR4jjI1HXmXewBd7Vco8olkF5i4f+t+Lmcx05I671sQ5UfumAphL4ThlkONTRGSavyFLhzAd9vHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgkWK9PImB8FFJUPGClp+YQSmI2PFnSn4FVKUwh2uaI=;
 b=4QeWIg72YTvMj4kAYe+fPNmRMB9oBblrgFxbKmB4Y2SHL4X7eJI+ividHeeqLeZnVkM4OcNm31ALsyWtXbN39ttFwClLpFHCiNUaEFkz9Dkb/hDFdHKHS3xKhGS8OU7nf0BF2D4GPaWSLWOxzrAOzdSvcrAzQSFyzq/W44e6yIk=
Received: from MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 14:56:59 +0000
Received: from MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::36d4:54ac:e00d:bf88]) by MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::36d4:54ac:e00d:bf88%7]) with mapi id 15.20.6954.025; Wed, 8 Nov 2023
 14:56:59 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Skip PCTL0_MMHUB_DEEPSLEEP_IB write in
 jpegv4.0.3 under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Skip PCTL0_MMHUB_DEEPSLEEP_IB write in
 jpegv4.0.3 under SRIOV
Thread-Index: AQHaEbEdPyZKwGuyTEWLefob7/zV87BwhBvw
Date: Wed, 8 Nov 2023 14:56:59 +0000
Message-ID: <MW5PR12MB56008A80B343DC4F2FC87748E6A8A@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <20231107193135.2360-1-victorchengchi.lu@amd.com>
In-Reply-To: <20231107193135.2360-1-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cf107e3a-129a-4a4e-b27c-a000433829d3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-08T14:56:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5600:EE_|DS0PR12MB7533:EE_
x-ms-office365-filtering-correlation-id: 7dfdec26-9450-4944-20ab-08dbe06af5b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DmEjETDO4h+vfhxB271ewQ5GuvCfiXaBB9GLmzCCiTgxQIo+gEFqfZRo1Wl99nN2ozpnO1QR0BvrrGF9oaxVwvjPIEPlN6q+LKEVkuRZjIhApU3QrBZEbDzbHlnmF/bT03n3TUv5TMD7qBYCBd75HIybar7Ev7ZIwmFzP34lBGbJE7U5kmlSKV1HQdmfbqFvr3GRyfBNU/6l6eJfmc7uX9vXyxPhAO2foftWKfcHMD7AKSyFSh8YRNlO8Rg2cIV4DpQ+2sSz2g2sWPi7SkbKJxDU2aKTJxz5Vp8g5ylVT5ZP/0LNKNHbZ5FSq+D+mkUhMPTqpt9dAZq1jtdLgwMClwEvHtmouTJwrJioVtfztT5PY3BU459/zc/XO8kxYbxXEQHoiBg7EMcXrMfuli46bqWPZBcYpZIMbk1+K1rFjzQysWInJrKudBw29Ejvaxq9MkJnI2hC9xywj4f76O4TECjssEjd+If0u3X2ImFRCa7IoL7gVAzM56FzahKtwDnnSvD7axs8wIDzmFQQWS9myWlOxxhXsombcAXozc+ySf0Q4giKSpMbtJi4Hd/+gAOopkFLrt3gWbXhx0jtvjDkVw2rdnIGcNxZEyvsTDakqPKnD4M4oDnL0SxhDTfp/W1KUAzryq/bV+Y1eE5v0WeHQD/50Ss8frAGY3xfaG6kos=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799009)(64100799003)(8676002)(26005)(9686003)(38070700009)(478600001)(122000001)(52536014)(5660300002)(8936002)(33656002)(86362001)(2906002)(316002)(66946007)(66556008)(64756008)(66476007)(66446008)(76116006)(110136005)(41300700001)(53546011)(71200400001)(7696005)(6506007)(55016003)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?phosSJKFUcwJfDR4p2xYcxCpN04mDDDR6Z+FfIQbPdsPHRR08ni1uQqF55iT?=
 =?us-ascii?Q?kwbAKNxc8hzs+tr4mHzR8Ki8MCzMhjVLgA1kmcqo72tfeYDiBsOZrc2xybNP?=
 =?us-ascii?Q?rvMTloZzKTMYsu3dGFKKUiYTXvi700If8Wg/xa2FG5kI/gj6bQ2s7voF4pAM?=
 =?us-ascii?Q?3Q4JER+wl6DSgP4BSXGXIP1qmKL4xLvXyrYrNEuCG+eHUEOR02uC5lW/Xy1j?=
 =?us-ascii?Q?dM27I/I6615JBKxZbjxSaX9fKAyNgEyMU03OROiaBC/s89RTJZFCfBvJtuY+?=
 =?us-ascii?Q?6tTtlLSCWWpEJ6zuzfi/D5B6QQsDYfMQvmm+wmQjhR2WsT/DP5byk+Rxn4Wz?=
 =?us-ascii?Q?TVpLnQX1aEV/66kIU0+Z7Ni7MYoQOplKeZWx9Kksc6JGXtmdmX0ie2A8YngH?=
 =?us-ascii?Q?QEuDwZKGoDt0tPr2Qr6yPnhflojexbQu1jBlhSbjoi3CKJkNitMtOYliRk7l?=
 =?us-ascii?Q?E8er6UCqtn1QHk5tg7EK8pixTTNvLfQ76KoiJ9YU4KG21c5y6P0O4L5WzWkF?=
 =?us-ascii?Q?v3Yr6+Ce8sTXptPhJt21f7abaAxE949W67Re8IUyX0gGtHOEP9Qo9gAnDIA/?=
 =?us-ascii?Q?m2IgwLm9Feb8OQ8OPtg+P3nirbMNzyx8g9V+jxnAfN47bKAmyWbRGf0QrQhz?=
 =?us-ascii?Q?n9zEQDKrJSZ3ftzkdqeFukE69gnszZUcHr5QS+IeRrGOEJjniM+6BZcBtQmW?=
 =?us-ascii?Q?PvstM3pqpZDNsLsIqcGwb1nkDSjZDHvnIyKL6GHtiD96M2e/dbbs4KScngR2?=
 =?us-ascii?Q?Xt8skl0tQ9bYaeR1hqExgalA3cfiQr0OjOPY/voahaCHmQBJ7io5ZEM4NnHC?=
 =?us-ascii?Q?uX0dPApiOn8iJjZ0lQ1/F8FxcI1WFTHBUF939jWtJvnKtC3ZkNBPtrRxpT+N?=
 =?us-ascii?Q?onYgqJ1JmeMFVK1iknLaON1jyj1bGXWL7GxYZjwPX+WI82JTSghPUNs/OKt6?=
 =?us-ascii?Q?A1qb2O+rfcqQV50WZetmWSP9KUBF+Mbs2kdMIXo23L5I7swbFQfTN7DPTRJJ?=
 =?us-ascii?Q?AYCojEmdNVmfWOY4MFHPSua+LnZP2/TOHA44ltQImDQyzb8tPYiJo5eQZYQc?=
 =?us-ascii?Q?jnF+JBoqolVPCKh1JkMEsPovRuRf3ujXTEe/ueTSh/fjmXqrxEUItd2nDsHZ?=
 =?us-ascii?Q?vkSrERZUYhkpe5+j7ZA/60OtgUl8BBe9cqz+mwCYyLmpl10Lffx07X2DPTbX?=
 =?us-ascii?Q?60lQWRr97msOprv9twlVFB5OW0BKnSVFDwUqQ5Jjt/JvsnkKSDGeU1iju/Qi?=
 =?us-ascii?Q?3StQlS4usKgQxS3/zaLC0pJInM5/cOLpqlKRLaOKXqxxBG+w1iSg4AbVEK9u?=
 =?us-ascii?Q?af6R+oVGnZRYnSoT62NTo7HQy8meSxbuATqX7RXCeN4uUcDWvFB8sgT/ogtD?=
 =?us-ascii?Q?3TJm4Sx1B2qcUHm5MdLFNTythYs948dWuaPWEDe0BGmNHJ8+HJcRcFnsyUdZ?=
 =?us-ascii?Q?MtztYvAZGX2KCyZf0pbIkR9juDwJp5MF7vvoiJQK4zOzR0HFmQLSmuQ7P1bt?=
 =?us-ascii?Q?SSShVk4r6LyigDan6qjFLslu9nc4k4t2En/FJuq1bOhpoPlj+J3EXbH6XRoQ?=
 =?us-ascii?Q?7D9prCsGBQdCBGR49JY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfdec26-9450-4944-20ab-08dbe06af5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 14:56:59.6438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Voj2b8lqmRPugZTW/lYC3AhiZCwugvMy3SO/n9YMchRFZ3XD3Ia2tWBYVsYQm7Up
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
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

[AMD Official Use Only - General]

Reviewed-by: Samir Dhume <samir.dhume@amd.com>

-----Original Message-----
From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Sent: Tuesday, November 7, 2023 2:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Dhume, Samir <Samir.Dhume@amd.com>; Lu, Victor Cheng Chi (Victor) <Vict=
orChengChi.Lu@amd.com>
Subject: [PATCH] drm/amdgpu: Skip PCTL0_MMHUB_DEEPSLEEP_IB write in jpegv4.=
0.3 under SRIOV

PCTL0_MMHUB_DEEPSLEEP_IB is blocked for VF access

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index 355d25fd6169..165448bed6c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -652,9 +652,11 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgp=
u_ring *ring)
  */
 static void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)  {
-       amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_O=
FFSET,
-               0, 0, PACKETJ_TYPE0));
-       amdgpu_ring_write(ring, 0x62a04); /* PCTL0_MMHUB_DEEPSLEEP_IB */
+       if (!amdgpu_sriov_vf(ring->adev)) {
+               amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_IN=
TERNAL_OFFSET,
+                       0, 0, PACKETJ_TYPE0));
+               amdgpu_ring_write(ring, 0x62a04); /* PCTL0_MMHUB_DEEPSLEEP_=
IB */
+       }

        amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
                0, 0, PACKETJ_TYPE0));
@@ -670,9 +672,11 @@ static void jpeg_v4_0_3_dec_ring_insert_start(struct a=
mdgpu_ring *ring)
  */
 static void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)  {
-       amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_O=
FFSET,
-               0, 0, PACKETJ_TYPE0));
-       amdgpu_ring_write(ring, 0x62a04);
+       if (!amdgpu_sriov_vf(ring->adev)) {
+               amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_IN=
TERNAL_OFFSET,
+                       0, 0, PACKETJ_TYPE0));
+               amdgpu_ring_write(ring, 0x62a04);
+       }

        amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
                0, 0, PACKETJ_TYPE0));
--
2.34.1

