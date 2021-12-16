Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593EFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 07:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18F510E974;
	Thu, 16 Dec 2021 07:00:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD2B10E974
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 07:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrzlLRaNy6kIlxuDuOB5W6yci2YlXUU16WGO0u0J0Kp5Svl430Ph0uvGxcXC7DoI6AYnNF6p1h2sKMI54W+vFrbkReg+OtBO+nZ75Niw4PLnjluJvd6BnnllY8+lPv3Odwgtg+ZRzxtjlly6rKb80MyaiRhzIpECzxWgdJqSmYBeBMVHzMZSb7P8UTNjipKAPldCyncWetgcKs+MXP5uYxM6OR9rVDsJex2adlX8HeVvT8bBPMB27hcqVRSWEA5Y+ZZFFfGIWneXH+OuBQiQe0+26my20gIRF07kMkRdpGZSG/tzJJBLG1FC7NvfVdnkqmrF6kF+EujbGNm/Z6JP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjHZ1nB03Gov8WkGyhTThbIsw8qaTaFKwVCUYL03gVg=;
 b=dwJTlCIuaYRxAG5XW7V7jFu6YOg+/GknGwMWR94VUL8CqhXyuV+FvFTI96Bo6C6qJIIzSV+A2go0JATmKEvmpu+Pz1KG6dQZ0+5TuXu4D23fLzBfAkFDkbCgWkpqwSMlaSK+oSKQ+ckFcF47hvHtkmylY0Oj/ZsKMPtM3+/WZIko277h/BH1m9elRj2lUurrKzdmhEhFPolViU24s8kWu9sdeEoyv+QBdTcSgSholt4gMWW1uOX94eN5Yrxw1E+ratm72b6HbEkbWOIMDEb0XMTXSy1XLONzi1z8fzASAXKIIIFRlRKqvMnRnUNed9ObQGZmRv7bRRvr6Bix9pFW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjHZ1nB03Gov8WkGyhTThbIsw8qaTaFKwVCUYL03gVg=;
 b=jE9W43NNWy01J0nnyU0aDsZ4dDzZoEH30EU2h85Sqf48J6+rC3te3Tu3VIClyhC6kxZKreVGe/+eMrdQUGJZGIGNsCKP9LucdxJaH6TaEH0dBALm2/ab2gSSoqUmysauYSvbaxpB0CybCEUk8X+rJhiQnO64ZDwjMbMe2gaBOpM=
Received: from CO6PR12MB5458.namprd12.prod.outlook.com (10.242.164.234) by
 CO6PR12MB5460.namprd12.prod.outlook.com (10.242.164.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 07:00:24 +0000
Received: from CO6PR12MB5458.namprd12.prod.outlook.com
 ([fe80::fdea:849e:21cf:3b20]) by CO6PR12MB5458.namprd12.prod.outlook.com
 ([fe80::fdea:849e:21cf:3b20%7]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 07:00:24 +0000
From: "Shi, Leslie" <Yuliang.Shi@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff device
 is unplugged to prevent crash in GPU initialization failure
Thread-Topic: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff
 device is unplugged to prevent crash in GPU initialization failure
Thread-Index: AQHX8kQdDxQmqcwLy0yjYxKLuJcpW6w0rL4AgAACwAA=
Date: Thu, 16 Dec 2021 07:00:24 +0000
Message-ID: <CO6PR12MB545814E39E2A95074E7924CCE0779@CO6PR12MB5458.namprd12.prod.outlook.com>
References: <20211216061342.2385661-1-Yuliang.Shi@amd.com>
 <DM5PR12MB2469859E35394E34AC2A7A01F1779@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469859E35394E34AC2A7A01F1779@DM5PR12MB2469.namprd12.prod.outlook.com>
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
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-16T07:00:21Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7fe0fca7-1671-4f40-861c-4eec4826face
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27befc8b-90ea-4613-485a-08d9c061bbc1
x-ms-traffictypediagnostic: CO6PR12MB5460:EE_
x-microsoft-antispam-prvs: <CO6PR12MB546087F3193FCF207CE8FB65E0779@CO6PR12MB5460.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7LmjUuWV8Mh8h+3XVvD8p7RRmLZrLYb/Vw+v6EL3cMRmnw0oEG8mZXzH3CTduQ5E7CFGBgznygwYYwJ2/SWfWrQB2f5mcdqaNQyRuunGfiRoAaHGp70njXNJuPw4xSvK/0Yn88HVdpVt8sdzP86chwg0OGZsWRdUaUvfDnVks2FQYSul7PycWgOtNqwRNXZT3LRvGHnl11n0penyDR/vxlJD+g4FNm6Ge5pSdL8F96RzS3C+EUHMiweXMvCqctGegtjj4Jjb+qm7boGsOqtyyYSrEFb8k+dLatIvNKztA6G24vORnDzYcX2t/z6XbbCKOIVL/dWtnUKi4oy1q1z3ie1+QlSBNeOReV1qLy0qj+3y9HpoBARz/we4YpN5uSt2VXeLZpQ2pL8bTcJvuPG6Ax8MCUqg+AZ15kUq42hoF1Hzr6k1wAljEFuGUwIE2vbbISpncgrisj04Y/v/jzFx8ljVgiYTDhJPmCxtggIsTHR4RDIXTDwzhCugzXSphn/2pPbxkYverkb39LiNpv+VTkp9END0+t5gOWYDn+I1XRC8elckgaSpAj/XWWME5XSvsxeb3dWbiq2iLtjqHbSZljRNIVyxOKOsZtVDCYWx1gCbTg4L/J/NxFGEsAjLM8IyXn9Ueugkzd53mDbHKByQ2emh9vyx5FYqg8tFfAzR/4bl1dAqWwBPFhvukRgvpbkyy5zKpfaH00qBtzcL1nclOeJRgZD+G8rAG2U5F8r6hw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(186003)(71200400001)(76116006)(6506007)(66476007)(7696005)(64756008)(66946007)(53546011)(66556008)(122000001)(38100700002)(83380400001)(26005)(86362001)(66446008)(33656002)(8936002)(55016003)(5660300002)(8676002)(2906002)(9686003)(921005)(110136005)(52536014)(316002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+a8bwuBsnmtLXSH+9TQW+ClLYQntX7c+/qldEaEG4cBoWb1O2xY1LNijijNS?=
 =?us-ascii?Q?yW8BigUz71GT+px3zXNdjdRhQV/a1hDaJFBDdcm7+15hIA9LHYTAU14SBIB5?=
 =?us-ascii?Q?zE5lSB1w2DgOW9KDqfvhZaz31CwWYrhuvzVEG4drubQ8h8Ams+QecI/uR08d?=
 =?us-ascii?Q?oeTGTtpDgE52wtSHU4HxyUlgt2DkZtQ2mkNoN1iCCddQBKN0X/Fqp+SS9tsL?=
 =?us-ascii?Q?tqDpm0egLX6tHUjRh1znJirZJ14cKV/JwTvLkeW+DT6c9RODUiwbgbezeUGQ?=
 =?us-ascii?Q?GCJw01LXZt3xYQWv6/AFLu5a2DwIdkkeKUprEXbjgeoz5242WpicR1XjFDth?=
 =?us-ascii?Q?uRlT4BlE0rKV6CDcIykj3JAg6kiMEPzUVXXQBtOKsWjGq5ibfkSTxlGWy43u?=
 =?us-ascii?Q?+xNsiCXrGHyZ4YU+wle/ZvMY5kWJa6tsQ3i9oc9HMrya3mID0XHeoqxp5615?=
 =?us-ascii?Q?IS3lxlY6wOmx1kTdUkNFgObagF/hsWf9xEoEVYJFALIKZR7Uft15E4PbkHaL?=
 =?us-ascii?Q?GxLJLDqYshsWFWm9Muaalc12/iPLdahBb176ErImDvTIqMXDCsGWFV330JUZ?=
 =?us-ascii?Q?t/wxnSJOxAdryaDZTeWfIyRbgD/qR1h6oYLd2Q3uun6OVgcMk5sjmWYZNOFa?=
 =?us-ascii?Q?z1M/tVUh4yyu7aL+hSPQ2E5hX/PDSzZH3ksTx6HdVsV7E2Rc34F/V6r2801X?=
 =?us-ascii?Q?euv6eaXWDBZes4KOPjvZ/LJxr/gk3TZvHQCbPv3APdXvabdrDKsg9+cxWMDt?=
 =?us-ascii?Q?iW3PifktKsWlrsCr52YW8hjMDLcAIfhZ2547SdYY+KzZPCYV3IH3dk78cHYh?=
 =?us-ascii?Q?0LLmHQbfJE9ectHsYpudMqaautQwbr21faV8sCJCnxqQa25Qt9oEEzV1VspW?=
 =?us-ascii?Q?1kjoaulkjawvNnIL/slhw1KbmpuTl9pZ0W1GnXkk92iGMC9WUXdMo/zHCpzb?=
 =?us-ascii?Q?jHw9rsP5/bP4Laolq0/VmK/83BQZ3CWxAtpmYtcV4RXDk/L2kws/hZOnwpuv?=
 =?us-ascii?Q?eVJBENlqqaulv+VRErt/65PJ4oBqgWclvnQP28QrRmeXBgIg1G8UXtADvUfP?=
 =?us-ascii?Q?oeDGWmP2p2GzDU4VupcyPOkFZ9Cmr9hehNjctg3JPNRy+GV+SIzORK1TdnQ3?=
 =?us-ascii?Q?LVlIlqYwKqK/k06XdpK9GI+r4hvihL6+Jat1H8/eun/+iPIbIgFAhYDqoDU5?=
 =?us-ascii?Q?9ZDsq7CW61/wfXxFZZpIgex46maTqW65BBurgw02Iy+NPVGhY+WLMR2UM9Iy?=
 =?us-ascii?Q?7g3mcB8ccwYFrWgwkg1v2u/YKC5tMdjgPviuRISvrherSyyuD6jAUW41RERz?=
 =?us-ascii?Q?XEj1Jk2FV/AvyNv7ucsZQ1XKIExvGEKnXstn1t2EM9gBeu9MsSF8e0LT5m4B?=
 =?us-ascii?Q?keElW1rlr3dilSNxs1iG9PoPQVipH8SmkBB5ecXTvr6tSddE2L0mE2dWG1RH?=
 =?us-ascii?Q?b3SkRlxRzZ72/btZErFD30QJuCgUNHWcNyyKh8z/edL7+5kv2875oN42ig2N?=
 =?us-ascii?Q?CulUhoSwaWnG4ia3Xq5YOkUHKowk8qcAVDOXZgN5uuRZ2hsjBtOnGmslHJg4?=
 =?us-ascii?Q?O7FLhiFKEJTz/PRae4jy51eT1DXMU1V67dFHgCzMaQEJ0TE7m9T++bD0hGzd?=
 =?us-ascii?Q?PX4J5S4ksUlZ+/BhQwI4XAI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27befc8b-90ea-4613-485a-08d9c061bbc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 07:00:24.1954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUDccEWDrq0wJ94A5F1ip+pb7vz6PyCdI1+SDPlyXObvaq0ibJdW4cK8dNejDeW42SXaFl3e0VjqLM4Pp/WbIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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

Hi Guchun,

As Andrey says, "we should not call amdgpu_device_unmap_mmio unless device =
is unplugged", I think we should call amdgpu_device_unmap_mmio() only if de=
vice is unplugged (drm_dev_enter() return false) .=20

+if (!drm_dev_enter(adev_to_drm(adev), &idx))
+	amdgpu_device_unmap_mmio(adev);
+ else=20
# 	drm_dev_exit(idx);


Regards,
Leslie

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Thursday, December 16, 2021 2:46 PM
To: Shi, Leslie <Yuliang.Shi@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsk=
y@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinh=
ui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@li=
sts.freedesktop.org
Subject: RE: [PATCH v2] drm/amdgpu: Call amdgpu_device_unmap_mmio() iff dev=
ice is unplugged to prevent crash in GPU initialization failure

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
