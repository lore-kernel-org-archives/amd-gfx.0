Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE83C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 15:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F189F10E831;
	Fri,  4 Feb 2022 15:01:01 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6605410E831
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 15:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXefhf2IPOqMsaKAwfCUezjeO21p15nfYQM2cqzJMhEouMlzcov6QeQzjF0894OM25zKZDbuJsMvC9FkVJkDE786KoQaxuu/TrJ6ldLJArSoJt3dQcb+dWyR38uC5dSjCwab06V6F26L+unXYgHsjvSgwdH61ILbBV4NtgTWkTfDPf8pe+0DhH4QcoVbN/9gZKH3nYDJ8DHW9NXpHXMsOBWXfvvvKdl9RhXA2ajVeI0pGDoLHahUzZtuZvUYL35tZu5WIYbU+cIETVKNuA1nrRxmAqKgf2LOFyHTjKOLPADkkRhQIhnCdmpvSMMG6ip5QumfNbGIEy3kpsDBVHa4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRQdLNRNwXRgzU1mn1KqkJRLQUwlld2VzE1j59hNQo0=;
 b=W3/EW55MHY5eYQDWVrzo6XdnPtd8X+Ht98a0bYJ+eK/cTy89A90cgd/Y6aBZEUF27nvjyseHs0ka8Fy2D/tySu+Bg8+cqOtYFsrLh2ORCIC5sCYuFzohJF9fErsqS7U27dYUeMnGARyWBEwFcwq2mlOBKgG2rjzaHkKElep8EoPbX6p3Ta8+0Ra/MuKKWKKmYW7tTDIJJI0p7OxAhlRkDWdoVQOXMBKvZLlhiuX5WLxVHdGDdTxnbGvxhK65DGUp/Pw6zip9/kraz7dD1DEk2G+GLNKC7FEfJB7hHqfansClKF11WgRazWzYNPG0tRHElI8Xl1av0yr/My//EAzPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRQdLNRNwXRgzU1mn1KqkJRLQUwlld2VzE1j59hNQo0=;
 b=g+fzqVPmvlYex8UvEdtIX6u+QOrnMryyKDPpB7Ju+YNSKzd0fp07yt6NkqQbO2Okvj2isF9MJfRHOYH1lkARhM5vgRFEypwVzh53xwkprC27rvWQAZdFEEheHOKyK0krJ1Xy8Me+ZbkgEKKPLnYCeIw982rIoqTxqgU5GRMXGik=
Received: from DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) by
 DM5PR12MB1388.namprd12.prod.outlook.com (2603:10b6:3:78::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 15:00:59 +0000
Received: from DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::1495:b6b7:8429:a5fb]) by DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::1495:b6b7:8429:a5fb%11]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 15:00:59 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1 3/3] drm/amdgpu: Prevent random memory access in FRU
 code
Thread-Topic: [PATCH v1 3/3] drm/amdgpu: Prevent random memory access in FRU
 code
Thread-Index: AQHYGYf1dg86UN0fZUyHsz63PVrLDayDfNXg
Date: Fri, 4 Feb 2022 15:00:58 +0000
Message-ID: <DM5PR12MB13239926F9E7657CB310F50B8C299@DM5PR12MB1323.namprd12.prod.outlook.com>
References: <20220204052724.469469-1-luben.tuikov@amd.com>
 <20220204052724.469469-4-luben.tuikov@amd.com>
In-Reply-To: <20220204052724.469469-4-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-04T15:00:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=11b8951a-27ca-4b28-b5bb-4798f1f71cb8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-04T15:00:58Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 66d1f8da-5431-4dc7-907a-902939c72011
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39c8296a-9001-4f77-0625-08d9e7ef272c
x-ms-traffictypediagnostic: DM5PR12MB1388:EE_
x-microsoft-antispam-prvs: <DM5PR12MB138847BA3F80FBC5427F33838C299@DM5PR12MB1388.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLUmXEJTtNhBOeW+tgdXd6pl1mIBWlJEyXOW2NmSxN3k/rO+GcsZlk4EIYtFD7xS5oDSr5mlELa1FsXbIg5XyqT/a1R+PxfwH0JiDNRDYnrUB1HIxcRh1vBKq4QKvba7j/vWI6GdB6jQNhBdd5tQsggQh/h2O4XlmjZXx7UN5hPFOaFbDOyC1XZDVA7ER/zPYx6f5bxuuMAA+XmGmIRM80p0ma8CTkKdLY5kCn2TWz+n7BpF2VllJH4FiHya5g5FFPobVv4lKDTfuj2p5/FOshBhiUc4OIkyHQiND5R8cT0O81zn0+cFI6c+LR0cCoj21fpYmlv9sqA2xmJjIfim24XrVt292P3NVTjzhptP1ck1jjj8fVnQJl5tsoXMXcA761FtgTeN7aKit20vdlaouAgNPn438Su15VFyUjHVFeGfuElYgZrxKWJ0sWiW8gisv+SFDpUB7GfsH3W7U7FZd6j2Y+q3+uNpZm8Nm96rfI/ZVhjE5TSJ9Y6wRAyRiViA4QQN9cewjBYhYYfvck3Bec16eT/mm2TMgjjcMfjUyU6mAq/9su6r8CNVhjZmuIAVBeHUAJob3C6xcCI7syyHic+mZdzhaYB9L6rvOaSzR0/ESqA/iHiCmzv2mQjW35xzv34Fx1IZk9BlM2iUPtc8ul+LXwnB4YzxGoeq/vhoJP6gpgjHPL7qBm3ZpIHhgxSZSokHDc2M4bY/Wk47l61dig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(7696005)(122000001)(2906002)(53546011)(55016003)(52536014)(186003)(508600001)(38100700002)(26005)(6506007)(33656002)(66476007)(66556008)(9686003)(66446008)(76116006)(4326008)(316002)(83380400001)(66946007)(64756008)(8676002)(86362001)(38070700005)(8936002)(110136005)(54906003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1kgfitxYAcvbq2g38gYT7COdbXiNMPzFQ+Kzhjv28fwfnWAZwVTAKfhZQqEZ?=
 =?us-ascii?Q?pKCZ++8jyPbkoqF8xIs8N1+eiodfT8uVQX+re26OBESmUlr3cLm+Gg+/Eq6k?=
 =?us-ascii?Q?poZMnSvN3MMBlCGHijOO4fBfTAlQCZj2qyjVyYNpyMPbZJvemfj07JV0VCpb?=
 =?us-ascii?Q?HSFhma5x2hiZaKGJiuPeVhoQke1HP1il5Hcy/HAoikeqyvOeMq+K+C5zoXQO?=
 =?us-ascii?Q?KNrX8RuDVqn7O+tiNIijzKSQZmOP7ZvGF/rH2lHqZ/nuqeBvCVGScg3XBaE+?=
 =?us-ascii?Q?mCymloJ/6IqJ5g25vMSmJytW+iAT3FpBegXbLXZYanDethNNpRdAFtxs/fiX?=
 =?us-ascii?Q?ZOUipLVYaO26c92STty3iXsQqiEYbmn6fh1nPJV3MrLdJu8kKTPENfApto8/?=
 =?us-ascii?Q?XMEZOIub5IjyrlDOnLGAlKQQGMAruGkAza2czy9FdlyXj4fc/H3TSnoEEggT?=
 =?us-ascii?Q?uBjsNXx/5yGSMuF/OQwE1rEHAO8+PkTydyF/6xbOYmsDhPlL8bGSuXHXS6HN?=
 =?us-ascii?Q?nMAFaOlixqLRo2inH/vs63I5drOBCjfta93DdWB9hC2v5IYRBH5Gj+je/wZZ?=
 =?us-ascii?Q?UWTtCWDhzSrPBG6kg4iThBSOGPdxwoPQwpAhih0Ly0/YRbGEPi6kvX/WiA3F?=
 =?us-ascii?Q?EghXk+Un0Hgd38jFoCTB/XN3HElRWyZRjYzXADyS2C/+VQ2qQh1kFJZ2BC7x?=
 =?us-ascii?Q?2GAPSppYOz9wWQj4hdp8ASC5IdLkBthFXJAnFZxsNSfhkcnuxugoD2plC4Hg?=
 =?us-ascii?Q?jgjFax4y7iY2Ipho0zqBTTlC4ODzpEVH2jJ4kLWJNYOTa9RPcYLtYd2hwa+3?=
 =?us-ascii?Q?H/PPDP1PAzBo++3PX0Xk0dlLNQGGmFzsqBXjK8cY97eQhOGWPw8rtLS/ELMS?=
 =?us-ascii?Q?NyQCl8TxQIwbEHmH9rOjldQul1uHHGJKLAl+fASzoWCXJKqaRdIOAlVRjvIf?=
 =?us-ascii?Q?S82niUPXsOH5Rl/Fc4RM+z4PkOethBck0rnXKSjT2aFaEmqJNAR/6+qh4boy?=
 =?us-ascii?Q?17kXdI5bDpbB5xSRp7QwBBqv7GLgdY2LZssewr4W6dwIJ7XRQAOxmvNRafPF?=
 =?us-ascii?Q?p7nMHH/TnpALuUifhAE4gSvFFC0q0b3uNAbuSHure5sWFYG6AHPrfHA0CoxJ?=
 =?us-ascii?Q?ULaoNVl+xrl9y8CV6BHrg9bdw987HWf58xjWf/c6Dh7xOHyFivGfAXWZh8BV?=
 =?us-ascii?Q?QZ/zAmhGhJb3wwLvAECVJy29T9wKbU+WHGhJoYFE7ZV7hYhJPOeLwuV1m37a?=
 =?us-ascii?Q?8Z4aJq8q+6Lxv3zuQY0P7qXo7KrwaoGPQcTNP/OZVQR8JaiuoOOh4NtabNNd?=
 =?us-ascii?Q?snQIawKQLpGjSdDlqprYTztpbDMfYS8L39n6Nm37YhyrHLCCyM8prNIgm4sL?=
 =?us-ascii?Q?chNBLYesl389ZNd9c7AHtJvrtNO0l9ULaYNWgGgD7m0jhSmKT0GODt/cXO42?=
 =?us-ascii?Q?+k/WQiwBPHbMpSQy0tKD+gMDv6Nv1ZvWTDqvHodIcTdDvCdFWzsBUXjZxKC0?=
 =?us-ascii?Q?iLfS2FVQk+ag45pi5Ad4Gv1e7zIQsnDiUREGTJVLKXG2+DgkkqrVCL+p7t05?=
 =?us-ascii?Q?QnwbIZyuT8emXtZI8aIl2wB+aduHcVPErWTuCRIFkURDJ5+1Pw6Ft5NUirq0?=
 =?us-ascii?Q?wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c8296a-9001-4f77-0625-08d9e7ef272c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 15:00:58.8938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsSY1yPN3nqZYee1IF6PdPiZPckJFo8jKplKCK9esckAMWJ1Xo8AhnnxIsDFy5FokhdlJMIjHBJBQdXVRqivGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1388
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This series acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.co=
m>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben Tu=
ikov
Sent: Friday, February 4, 2022 12:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben <Luben.Tu=
ikov@amd.com>; Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH v1 3/3] drm/amdgpu: Prevent random memory access in FRU cod=
e

Prevent random memory access in the FRU EEPROM code by passing the size of
the destination buffer to the reading routine, and reading no more than the
size of the buffer.

Cc: Kent Russell <kent.russell@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index 61c4e71e399855..07e045fae83a9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -77,9 +77,10 @@ static bool is_fru_eeprom_supported(struct amdgpu_device=
 *adev)
 }
=20
 static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t add=
rptr,
-				  unsigned char *buf)
+				  unsigned char *buf, size_t buf_size)
 {
-	int ret, size;
+	int ret;
+	u8 size;
=20
 	ret =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buf, 1);
 	if (ret < 1) {
@@ -90,9 +91,11 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *=
adev, uint32_t addrptr,
 	/* The size returned by the i2c requires subtraction of 0xC0 since the
 	 * size apparently always reports as 0xC0+actual size.
 	 */
-	size =3D buf[0] - I2C_PRODUCT_INFO_OFFSET;
+	size =3D buf[0] & 0x3F;
+	size =3D min_t(size_t, size, buf_size);
=20
-	ret =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1, buf,=
 size);
+	ret =3D amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1,
+				 buf, size);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
@@ -129,7 +132,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 	 * and the language field, so just start from 0xb, manufacturer size
 	 */
 	addrptr =3D FRU_EEPROM_MADDR + 0xb;
-	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
 		return -EINVAL;
@@ -139,7 +142,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 	 * size field being 1 byte. This pattern continues below.
 	 */
 	addrptr +=3D size + 1;
-	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
 		return -EINVAL;
@@ -155,7 +158,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 	adev->product_name[len] =3D '\0';
=20
 	addrptr +=3D size + 1;
-	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
 		return -EINVAL;
@@ -173,7 +176,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 	adev->product_number[len] =3D '\0';
=20
 	addrptr +=3D size + 1;
-	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
=20
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
@@ -181,7 +184,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *a=
dev)
 	}
=20
 	addrptr +=3D size + 1;
-	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size =3D amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
=20
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
--=20
2.35.0.3.gb23dac905b
