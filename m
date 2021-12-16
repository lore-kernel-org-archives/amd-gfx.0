Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C542C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 06:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D535D11245E;
	Thu, 16 Dec 2021 06:46:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5779D11245D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 06:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9cIqwFyFKNY/qFTDxWXyA8y5S4DpjK/nzmBJrTGVtwkhn79TzaL7CZSks5DEGWpSNkOtBTDg+X7yZH5ql0wx/VHkoKnFfQYu56Chxnt2EFqbmHoO+uEjYoN6I+sMtLiH1EcenJwHI9+9mQlNGsJpIpv3kljhXN/7qRVnbclKLptwJPkkZTp5+nlw3Vy2sE6hu4cHCvYeLhupK0zXCRYJzEf26oSVze0OQmWYW5N1Cn/l5Xr4o8+xtDWoQInmDukU+8wvqo6lSgm5iUPhIbcxmLyEB7nfbNXY6lC+mcwNBp8eDOPjexRMBtxqyAXY6wgn4MgTyxpr/Q4Z9cb5TDzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG5fnyzhN/+EjYBgZUAFRWYISZESBd8DxEisa2zKs90=;
 b=khgDfpvsU8JJxAyYMzk/KPEcjqXT7kXKB/H8BKkEx1C9CW2szj6NpNcjI/wwOO4Helev/ZZEA2PJk9uVX04XOpgBdYvNDZytmPO/NNy3x1COhcxWgI1QweHA1ir+s6Tef8PqnUQNPw2gEceZpdG0N4HT3lKtlMmCWlUHJ/y5KLPATthjDiW+9p7ZC/niuObF1oGems/hcdxn+AFsqSspL+u5xBLSg+aT2w5mulB8Vs1yBP73Ky4GlgZSLjRwsb8XvukDzbm1/+dFktCtQZOWaMIEfQMn47HQg7M0EzfrY9xKdEVjDugI+siFojWoK4NUIdM1TBYQW+Ps2+yxHVSwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG5fnyzhN/+EjYBgZUAFRWYISZESBd8DxEisa2zKs90=;
 b=hfqlhpCb6dYIpw7lmifF4EVR9r/DLdc6atSzr5IKa/vABpLrkltFjvvbfFmGNjngAq1VB8TLk0bXvx9lFTCad5NR/uCP3W+Jw54ICHu6Qdoa1lU+bZw3Ghr9yGbOEAgC8nclU3szsS0Js/zzUgO+ZCaPu9fNsd2I7EH3nrCvSSc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 06:46:22 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 06:46:22 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device
 is unplugged to prevent crash in GPU initialization failure
Thread-Topic: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff
 device is unplugged to prevent crash in GPU initialization failure
Thread-Index: AQHX8kQdcX5J8Yep0USGQsEri35C/qw0q+FQ
Date: Thu, 16 Dec 2021 06:46:22 +0000
Message-ID: <DM5PR12MB2469859E35394E34AC2A7A01F1779@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211216061342.2385661-1-Yuliang.Shi@amd.com>
In-Reply-To: <20211216061342.2385661-1-Yuliang.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-16T06:46:14Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6df1ece5-3d8e-4cad-b7a2-b6205aac7b55;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-16T06:46:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0dda8897-2976-49d0-a9e2-793ef841a100
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 666cd676-62b1-490a-912c-08d9c05fc607
x-ms-traffictypediagnostic: DM6PR12MB4153:EE_
x-microsoft-antispam-prvs: <DM6PR12MB415379CBAB97145BEA105967F1779@DM6PR12MB4153.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2zqUDrHLkz7quLJyDykPyZKxpy8iiV/sxw1Ww5Mnb41BbIfiAa07k+fxjweXq7CqOk3IeZ984JJDH1K8T7mDvsaagnfU/6EFzZLw8Yaljb+Z5LWlzVnSdzfc3uDLUBmXslEJ5Edmrv4I1Zpv7Jfy7LslKpQth19vC8lApxn0YvRC1tN/o1Br7XWZytGDP7JuH4/OuOn0HNwxPEXVnN7xG4MH7Fo6W2+cQmxhKTRrUCwYKVdpzhGF2N/TQidu+avUmaxo5AJEoB683RxO/W22n4UeHivwQDyKroipQfEdXcQ2VFW30s+V2IgcyfZAF0sDWJIxqW0H38dr4vY1raPXZGTjTTzuMglxKcRr5G9ZXD4T6x7YgIliWsL8Ewdyvtms21uYqeSsS1QVSGGymyuE2HM0JA9ga4b3UHJ21+hCIq+kAZlYNm8adQrTvNxpxqPNAujXp7H8uzjU5Tkc3su7wEh+uQou6m1zncleLWZdx5OGvs20jn0ZNLXMxhGjZYFjVVGHI4gXZfNQ3bHaQW9mdY17s30glhIPMl9+djNKctbQp3DdcsrFj0056E3dQqo1gN0QEaw1STVTlcxnbUOkvjNBNQr+InW2n1rUgVJ8xNeLiOUTqet4s0xyso8yqdiyt3iIXzDwbguQnc12+nRn9oyIWQxjsvtkT/mK320Z8Gc0wfawib1+oR6aAzkeX7k3Hk0A5VHpxVM7RXMUx1e4gEDnyezbZjYcBH0PAJAngU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8936002)(5660300002)(110136005)(52536014)(7696005)(9686003)(66946007)(66556008)(64756008)(66446008)(26005)(66476007)(316002)(53546011)(508600001)(38070700005)(83380400001)(8676002)(71200400001)(6506007)(76116006)(921005)(2906002)(86362001)(38100700002)(122000001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R2NzUxRTjYMfmHf1fIRgCqSZ3TXvJz2ywPB3p234uS6X9HjCT+7qlKdduEmd?=
 =?us-ascii?Q?7hu1A3CGPAQId2vO39Ad9PQlE96xaS1nqgOZ+5z7mUTY4nFP7U4cw+dd3Ql9?=
 =?us-ascii?Q?BgM1esIhx8OH58ibQzZUXw3wY/0sUlr3mGmSS/S73ucbC+axhPNWx4WyTmqB?=
 =?us-ascii?Q?dtb42ndzgdy2tKp1LwQN4im5kjFYiWHVSiDn9/aRucPaB2f0MkBkXwT4NDHE?=
 =?us-ascii?Q?4YXoELWLrdNAj2ZMtW87eh/zEmmYexdG1Lr7VxowDpHPi6LeA/qbWUzUlbIy?=
 =?us-ascii?Q?tJdIiC6ssRwoqtrvigqHuTDbqTTgc5sFXggTjunxVaUS+7azZ+yUbdz4JMOs?=
 =?us-ascii?Q?NgYWVoLcGrpY8iEGbcwOs5Gnyg0C03ZVXwa2vVdEmfrrZ8v2nzGe1vPTrhqg?=
 =?us-ascii?Q?CTlZVzDk3NL/jmK88aNYyQ2k/5o3lThdw3lQKXIK3cyV7tI6+zVFSfC7+ATf?=
 =?us-ascii?Q?FNwl1B9SKqA+kCmd/zw0AWIJVxrKPmfR2xS7fJhgVVS7HVr7JSwn8QLKN6hA?=
 =?us-ascii?Q?c0u5ctLbCg5X9JnW0w6TjBd1b8wx6zqqP4UXpfX4fReVe42kid0nzyYFueez?=
 =?us-ascii?Q?A+wkkeupFKkfPkFshdZIchTcEh2gnvaeR4UA1RuASOUaNfUiBXP/cFDiP2FV?=
 =?us-ascii?Q?wkIzdX0iNNcyudQbyaTjmCkDc7+Vk+X8I3MlS/mtMaJAiD0UhsTxSuI3qTGZ?=
 =?us-ascii?Q?4Th4Rrx38D9Br4vnGgUbs+9gFRmerijcmnUDQH6JNlol7edrOzTyJQV4QW8b?=
 =?us-ascii?Q?yuW8S62PCB6skgmM072OxqD66ulzOkCKhMSMO3884wU3WZtEu4EPe4VyudkJ?=
 =?us-ascii?Q?wcPEkBHgrbItEk1pudllcpvOCq/twOu9hPqKnXu8ekJbBXUTNukU1O2S/hxW?=
 =?us-ascii?Q?BO/evuWoKwFY3VFH//ovH5Ixa4LdOMXMb7JZXMFv4wmcTTfhpB9yjYeSYqco?=
 =?us-ascii?Q?sp7zxIo2w2rC4wqSAB6tuzxBj2keOY1VXgtxc9tKn6lE9UMzFelabX+wf/Lv?=
 =?us-ascii?Q?pMO/dPgU2YrgaUPw0FAgDFKH/B9Sr1POeCz04hDnFWJYjp80wK1drr5rYgM5?=
 =?us-ascii?Q?g7ps61/wHEF1kY0Zo+loqjVcsDOAa5Xc/mxupRH0+UUX9xsjAdVSRSfOCXif?=
 =?us-ascii?Q?VeztmTGygpWnxHCSG7A6DWVTXk8t0q4eK376XdIdBCk8fvt+EGXw5XuH6x2j?=
 =?us-ascii?Q?akIM0Iayi4om5Z0gAb1CMoOdLD3TJGlZY1pw/sf/2mGx/3ivu4em+g33Tb+D?=
 =?us-ascii?Q?4tl8yo94nhlam7xnxZoXN2ZII8cuaMfCl3+T0SBy0mRZ3T99YrYDhcuh/KQA?=
 =?us-ascii?Q?tb8vLejQNvkh+UjmGHxx9L3GKmIoLNmnJ+rBjJerSoqGzqoQlHF6/f2zDbec?=
 =?us-ascii?Q?7FCHxwMfCHq9v8GVXYGtJ2Ias77UMdyw5JPn62LTlRCzIDOWAoMp6RwkVVGP?=
 =?us-ascii?Q?MRLSmxU66FEcsM/8Y0mthhj8KHpK24FjW+Hio5sW5AcQPN0uJsGUFVmW0rkg?=
 =?us-ascii?Q?knY81n7MYw8cxXXy/v2niy5r07w0rubig+s6tHn3+D5s6ilBHKfd63qDpMS1?=
 =?us-ascii?Q?7q1ML31lda1O8l53/KCwS2ULgSMLRqDIt4G+WNKvkrr3hTneFcsbA3lhpY8H?=
 =?us-ascii?Q?9p7N3HGQkszTXKi+cZT2f9I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666cd676-62b1-490a-912c-08d9c05fc607
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 06:46:22.5665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yt2PRdpRnGKzP9HaiRkBKQ3eLwcdvvYJWT0UqSXDcyyh7Gz7sroLVzYn5NGk/ila3KfWlCsxtrZsQBXZks8ihQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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

[Public]

Hi Leslie,

I think we need to modify it like:

+if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+	amdgpu_device_unmap_mmio(adev);
+	drm_dev_exit(idx);
+}

Also you need to credit Andrey a 'suggested-by' in your patch.

Regards,
Guchun

-----Original Message-----
From: Shi, Leslie <Yuliang.Shi@amd.com>=20
Sent: Thursday, December 16, 2021 2:14 PM
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>
Subject: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device =
is unplugged to prevent crash in GPU initialization failure

[Why]
In amdgpu_driver_load_kms, when amdgpu_device_init returns error during dri=
ver modprobe, it will start the error handle path immediately and call into=
 amdgpu_device_unmap_mmio as well to release mapped VRAM. However, in the f=
ollowing release callback, driver stills visits the unmapped memory like vc=
n.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.

[How]
call amdgpu_device_unmap_mmio() iff device is unplugged to prevent invalid =
memory address in
vcn_v3_0_sw_fini() when GPU initialization failure.

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index fb03d75880ec..d3656e7b60c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3845,6 +3845,8 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_de=
vice *adev)
  */
 void amdgpu_device_fini_hw(struct amdgpu_device *adev)  {
+	int idx;
+
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
 	if (adev->mman.initialized) {
@@ -3888,7 +3890,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *ade=
v)
=20
 	amdgpu_gart_dummy_page_fini(adev);
=20
-	amdgpu_device_unmap_mmio(adev);
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		amdgpu_device_unmap_mmio(adev);
+	else
+		drm_dev_exit(idx);
+
 }
=20
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
--
2.25.1
