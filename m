Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29E4C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 18:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B48613CE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 18:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B48613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128996E979;
	Thu, 17 Jun 2021 18:00:20 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 266136E979
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 18:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNoheLHqZDFdQfLaLp+aBEdcYrA3/shCedPaPHXmY7WMahPIPHs2TxB9zJQL/cJ+dV3iu3RbKwKIgasnab3YIXtOsRmAC5VN7zNIFp1ZCBDHs0b3rNYSvF98CE885VzUfjm9MnFuYvEwdkC6peGPExHL8tNrLAyVhr6V2rNDbq8Sb1xu1FZ+2d8qz5D0a93nVESnNc6pJ2g8ju5MRLUPg39hk4FRwanpU16VTvn+tu389nBJp9ifHX8D3R+EEQC1JGzq6wzRhhCIvAFtUWaPSIojhBxvNADz5Ns0Os9wfHVn2GLdx1ELl9ArU8wD/Nukilt942OZGxoMUxtUOL1mGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAYRZC+sUfZQA6xnTQDd0Z2WdJ0qwtLLEBeK+8NigJc=;
 b=apxqDplKFWGJbBs2ANHqJLwOyiL90xd5ilRE64r0h0wzYd89v6TEKSt3qGiG5o+GlhFA8KDwy8qK/oG2TlvRYY7ccL0tBgdFeLMa4ac4VUYnoErubpuFYBcIPdtQ1PzHMHYWJ2DiAEe001jKZOQ0350nbJMrkhCkgT6qEBv9XwV1M14esbtfe4rWtLJJS5f48KTW6K88m7lRph/TscyvBAenRl7SzGCtfaAnu99VUwbN9eDDwnx06Kw7EbI0wceSQV2sJ0lM9G9T2apzqs8noyS213FjiLZs9nLb/Ws3iK77bHYSJKWit4npgVkV48qtRjgivR1Q3rC7GfmY1rE73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAYRZC+sUfZQA6xnTQDd0Z2WdJ0qwtLLEBeK+8NigJc=;
 b=fBIC1/QokY19czcnhlPxr8qk+BWHKV7hJNYTvP33RB4PB7hP7J1avhJ7lq4aYVksdTxQW9KEHrMzVUG37OScWJd+llBGDV8LZqCenGqArsU8jtc2Pe76L5Z0kV/0fkwi+unUU0cted64cP0j1YPOjpGo6YZdCilo9Rfeqb8DMnE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 18:00:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::3c38:805a:5664:9047]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::3c38:805a:5664:9047%3]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 18:00:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amd/amdgpu: Use IP discovery data to determine VCN
 enablement instead of MMSCH
Thread-Topic: [PATCH v3] drm/amd/amdgpu: Use IP discovery data to determine
 VCN enablement instead of MMSCH
Thread-Index: AQHXY0zhn2tUcx/nfk+YD5yic0ADhqsYfo8H
Date: Thu, 17 Jun 2021 18:00:16 +0000
Message-ID: <BL1PR12MB51442AC284F10305E2C8644FF70E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210617074603.11417-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210617074603.11417-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-17T18:00:15.426Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02d51db0-c229-480d-6906-08d931b9c325
x-ms-traffictypediagnostic: BL1PR12MB5335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5335B1C21FCC1A0A13016649F70E9@BL1PR12MB5335.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1DJZ7xwrKGv0MFCpaG1l3y+aRHckTjQ6EKZwCOX2gp02gmLamenWSYR3ECQNUfteCZrErSCDjK1tG0vpVSd0wFT5Hd0PZW300S4HckmY5VrR+KOTNj8x9PkpGD7wqDoXSvRQYM9fguPy9u7VbJ/RgVEoDXdrFUWYpteWdKULt7FoB3WsRpUo5NBZUf9ZQ1ue/Vkesq5EDuspjiohhmsNz4XOojm/vVfmNYKHzKrA6laDqBktdfrUSztKgDH2G+oXMxTabl9jJVH9oIfOAGEIuxw9khJlcI+0zBA7JRNeH3ViH65KOIM6vuFvrXte/UDLKknmxKr72t6OSLyIsVSWfiekgy5zkExWC9eVj7dGl2QTvLSjOKBUvCBRlr5V+L8zffpBMKOvyx6qkuUkD8l7JaX7aFXR0sqH5fVN8yMf+yAqx9/RWdK9HRmiBC9RayC6owNv5TpT7UxoWLShLVCMMSk3wFXgVGHH0PksAWzGt+fMtFi4v75gw0dR0+FIfZtQ1I21Vsxdpwa3b38IjcFDN4Mt154gg+anxoLLWj3Si01QVW1mnrYdTti9PXdMSCRksDcrsoll0hh6//Xr/ZDzyBBsLNQV7wG188RGUXe75JL+S/JAYSsYqSqPL6FEQSbEwuNjGO/PiBs9v8mZzgIhSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(9686003)(38100700002)(2906002)(7696005)(76116006)(478600001)(53546011)(55016002)(966005)(45080400002)(122000001)(64756008)(6506007)(186003)(66446008)(66556008)(19627405001)(8936002)(166002)(66476007)(26005)(66946007)(86362001)(316002)(83380400001)(5660300002)(33656002)(4326008)(71200400001)(8676002)(52536014)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dhjXVhjY0I2aGxyI/peBw0Cd8DnmGkWfgcHHa3mhDYB0j5aruJlONOKl6MFe?=
 =?us-ascii?Q?J39ZCTITorBqj+c4v+ibz1o+VVL0YJTsVpiqNK28tLEF7UxpCuuhJebkAMc4?=
 =?us-ascii?Q?5jXVRMqRhurFrKR6vbwhX/3g8ZawVFIexA6n2FcTVjSnXSIEAaqLrYNIIyPU?=
 =?us-ascii?Q?PibvOBmAH+mnElRapagTPWYAxARp2W4h/AAn1U9FczD8YfMBhqM442T2KnnH?=
 =?us-ascii?Q?89fBbxeItrSTVuXpVFE8WLVbgFDX+xDtR2zaU2+JaZwDxnxF/YRYluI4IsD+?=
 =?us-ascii?Q?B0B9sW+c9SwUycXFxIwsDNg4qJPPrapLv4yRHHjC53n10dSIDaKyjNN8a+Wk?=
 =?us-ascii?Q?e1AeLuXqjyQH0bEGHMzHLAiwk30FnRck5XJjeK6Q7ODB1RXzihuTgzS9DPMK?=
 =?us-ascii?Q?lieKegk7uWlqiJriWJ2cpEVg1EccuvZI7mTt0c4QX3ic1IIKmVApIFsCJFUv?=
 =?us-ascii?Q?smSaAdUApHgQa+05roSxv74OPM5AeqYA7RoBEDzHjjeh+MrA92qtKf6ZsJSK?=
 =?us-ascii?Q?5ZdhELl0hT3DnKVekLsZKsfEkzL8XDKaG3C0ngJzJqiX3DkCLBBF5vEFkJ39?=
 =?us-ascii?Q?iUPtbeCzXwvqCd+aGVL6awSrwgr//lHeOr6ek4mjanZEaTFaUPrY1jKeFAJ8?=
 =?us-ascii?Q?k120m4UmoXo2GH6sMl8hpSWHA5opxM7N+2FmrBgcesSB4H0zhNpy5NNr9VU0?=
 =?us-ascii?Q?JhhwCO8lnfSjvYyAkSUMa772WZqhXguxiYTgS0irVpD8xch0RlAlI29N95lt?=
 =?us-ascii?Q?eITM0K/Jxx/ePpnwWNVngYjv0PQALgvzhLoNyN2iYc2tqk/dnWRq0JWMeAvz?=
 =?us-ascii?Q?JevnAuW7A05Fk0OizP6LIf9Bsf1IWpgGE4elzrWe2EZmvBVlrH6GQ8cqjp0N?=
 =?us-ascii?Q?sXEwhgrDjFv8xiQSF0zNm38bNQuNYo0JI0H7GfMGHYI5TdjuyzVOeClEg1hC?=
 =?us-ascii?Q?JZSY6J3Yl8gPpMwfub5k9nixvrgExjdyV/1wlPePaWP0JrRVgz3VzXGrvhhf?=
 =?us-ascii?Q?sR0ZYTzqj4g7UQcjbVW7DqkzSz7Lva2AXc3oibPlCGOiYPnneyWRjedNPGxM?=
 =?us-ascii?Q?GMfWl+3OoIGsAvs83vJidS8EUeGPuQiSDdSmCebqUZaL2mAkeImLPBOmvgtT?=
 =?us-ascii?Q?uZZO//lREAcpSmQwZkMhGoG3Cgokc/Hod+Kh04EoK1wIO0ckwigXJUpEatXK?=
 =?us-ascii?Q?6ipyyxJ/8tR29q/3yhlzf232ycJm7MXF7Ltofzh1ORjsW8k7v7ocuee8HNoZ?=
 =?us-ascii?Q?TuS9IhuplnHnDg/9wu8N3wCHMt1Eqy8Fr6Qts78yKA5jr0q60NSPnBFhrhV1?=
 =?us-ascii?Q?dQxygmvd9JJg1ULNySqvwvyK?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d51db0-c229-480d-6906-08d931b9c325
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 18:00:16.0692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qei9puO5gCJSJRYT9zs9MupZhrlQ/qmR9cqBUMW7b1aEERfq81LFV19WbRKL0e/Yi86iGYJYdG5vbShuVY6sgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0529255149=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0529255149==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB51442AC284F10305E2C8644FF70E9BL1PR12MB5144namp_"

--_000_BL1PR12MB51442AC284F10305E2C8644FF70E9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Peng Ju =
Zhou <PengJu.Zhou@amd.com>
Sent: Thursday, June 17, 2021 3:46 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH v3] drm/amd/amdgpu: Use IP discovery data to determine VCN =
enablement instead of MMSCH

From: Bokun Zhang <Bokun.Zhang@amd.com>

In the past, we use MMSCH to determine whether a VCN is enabled or not.
This is not reliable since after a FLR, MMSCH may report junk data.

It is better to use IP discovery data.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  8 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 23 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       | 13 +++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 53 +++++--------------
 5 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index f949ed8bfd9e..e02405a24fe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -373,6 +373,14 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_devi=
ce *adev, int hw_id, int n
         return -EINVAL;
 }

+
+int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_i=
nstance,
+                                    int *major, int *minor, int *revision)
+{
+       return amdgpu_discovery_get_ip_version(adev, VCN_HWID,
+                                              vcn_instance, major, minor, =
revision);
+}
+
 void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
         struct binary_header *bhdr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.h
index 02e340cd3a38..48e6b88cfdfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -32,6 +32,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *=
adev);
 void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
 int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,=
 int number_instance,
                                     int *major, int *minor, int *revision)=
;
+
+int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_i=
nstance,
+                                    int *major, int *minor, int *revision)=
;
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);

 #endif /* __AMDGPU_DISCOVERY__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 9492b505e69b..84b025405578 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -287,6 +287,29 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
         return 0;
 }

+bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_=
type type, uint32_t vcn_instance)
+{
+       bool ret =3D false;
+
+       int major;
+       int minor;
+       int revision;
+
+       /* if cannot find IP data, then this VCN does not exist */
+       if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &m=
inor, &revision) !=3D 0)
+               return true;
+
+       if ((type =3D=3D VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_D=
ISABLE_MASK)) {
+               ret =3D true;
+       } else if ((type =3D=3D VCN_DECODE_RING) && (revision & VCN_BLOCK_D=
ECODE_DISABLE_MASK)) {
+               ret =3D true;
+       } else if ((type =3D=3D VCN_UNIFIED_RING) && (revision & VCN_BLOCK_=
QUEUE_DISABLE_MASK)) {
+               ret =3D true;
+       }
+
+       return ret;
+}
+
 int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
         unsigned size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index bc76cab67697..d74c62b49795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -280,6 +280,16 @@ struct amdgpu_vcn_decode_buffer {
         uint32_t pad[30];
 };

+#define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
+#define VCN_BLOCK_DECODE_DISABLE_MASK 0x40
+#define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0
+
+enum vcn_ring_type {
+       VCN_ENCODE_RING,
+       VCN_DECODE_RING,
+       VCN_UNIFIED_RING,
+};
+
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
@@ -287,6 +297,9 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);

+bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
+                               enum vcn_ring_type type, uint32_t vcn_insta=
nce);
+
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index 798b6b4d8f46..c3580de3ea9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -85,16 +85,18 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ri=
ng *ring);
 static int vcn_v3_0_early_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       int i;

         if (amdgpu_sriov_vf(adev)) {
-               adev->vcn.num_vcn_inst =3D VCN_INSTANCES_SIENNA_CICHLID;
+               for (i =3D 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
+                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RIN=
G, i))
+                               adev->vcn.num_vcn_inst++;
                 adev->vcn.harvest_config =3D 0;
                 adev->vcn.num_enc_rings =3D 1;

         } else {
                 if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID) {
                         u32 harvest;
-                       int i;

                         adev->vcn.num_vcn_inst =3D VCN_INSTANCES_SIENNA_CI=
CHLID;
                         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
@@ -149,7 +151,8 @@ static int vcn_v3_0_sw_init(void *handle)
                 adev->firmware.fw_size +=3D
                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZ=
E);

-               if (adev->vcn.num_vcn_inst =3D=3D VCN_INSTANCES_SIENNA_CICH=
LID) {
+               if ((adev->vcn.num_vcn_inst =3D=3D VCN_INSTANCES_SIENNA_CIC=
HLID) ||
+                   (amdgpu_sriov_vf(adev) && adev->asic_type =3D=3D CHIP_S=
IENNA_CICHLID)) {
                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_i=
d =3D AMDGPU_UCODE_ID_VCN1;
                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw =3D =
adev->vcn.fw;
                         adev->firmware.fw_size +=3D
@@ -319,19 +322,17 @@ static int vcn_v3_0_hw_init(void *handle)
                                 continue;

                         ring =3D &adev->vcn.inst[i].ring_dec;
-                       if (ring->sched.ready) {
-                               ring->wptr =3D 0;
-                               ring->wptr_old =3D 0;
-                               vcn_v3_0_dec_ring_set_wptr(ring);
-                       }
+                       ring->wptr =3D 0;
+                       ring->wptr_old =3D 0;
+                       vcn_v3_0_dec_ring_set_wptr(ring);
+                       ring->sched.ready =3D true;

                         for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
                                 ring =3D &adev->vcn.inst[i].ring_enc[j];
-                               if (ring->sched.ready) {
-                                       ring->wptr =3D 0;
-                                       ring->wptr_old =3D 0;
-                                       vcn_v3_0_enc_ring_set_wptr(ring);
-                               }
+                               ring->wptr =3D 0;
+                               ring->wptr_old =3D 0;
+                               vcn_v3_0_enc_ring_set_wptr(ring);
+                               ring->sched.ready =3D true;
                         }
                 }
         } else {
@@ -1298,8 +1299,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device =
*adev)
         uint32_t table_size;
         uint32_t size, size_dw;

-       bool is_vcn_ready;
-
         struct mmsch_v3_0_cmd_direct_write
                 direct_wt =3D { {0} };
         struct mmsch_v3_0_cmd_direct_read_modify_write
@@ -1491,30 +1490,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device=
 *adev)
                 }
         }

-       /* 6, check each VCN's init_status
-        * if it remains as 0, then this VCN is not assigned to current VF
-        * do not start ring for this VCN
-        */
-       size =3D sizeof(struct mmsch_v3_0_init_header);
-       table_loc =3D (uint32_t *)table->cpu_addr;
-       memcpy(&header, (void *)table_loc, size);
-
-       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
-               if (adev->vcn.harvest_config & (1 << i))
-                       continue;
-
-               is_vcn_ready =3D (header.inst[i].init_status =3D=3D 1);
-               if (!is_vcn_ready)
-                       DRM_INFO("VCN(%d) engine is disabled by hypervisor\=
n", i);
-
-               ring =3D &adev->vcn.inst[i].ring_dec;
-               ring->sched.ready =3D is_vcn_ready;
-               for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
-                       ring =3D &adev->vcn.inst[i].ring_enc[j];
-                       ring->sched.ready =3D is_vcn_ready;
-               }
-       }
-
         return 0;
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C10420624e72c44cc5edd08d93163fe4e%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637595127876624163%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D5MzzuTLBnE5tFffBAMinenV5MVHWOG0lZH3jAnBbvzg%3D&amp;reserved=3D0

--_000_BL1PR12MB51442AC284F10305E2C8644FF70E9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Peng Ju Zhou &lt;PengJu.Zhou@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, June 17, 2021 3:46 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3] drm/amd/amdgpu: Use IP discovery data to determi=
ne VCN enablement instead of MMSCH</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Bokun Zhang &lt;Bokun.Zhang@amd.com&gt;<br>
<br>
In the past, we use MMSCH to determine whether a VCN is enabled or not.<br>
This is not reliable since after a FLR, MMSCH may report junk data.<br>
<br>
It is better to use IP discovery data.<br>
<br>
Signed-off-by: Bokun Zhang &lt;Bokun.Zhang@amd.com&gt;<br>
Signed-off-by: Peng Ju Zhou &lt;PengJu.Zhou@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |&nbsp; 8 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |&nbsp; 3 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 23 ++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 13 +++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 53 +++++--------------<br>
&nbsp;5 files changed, 61 insertions(+), 39 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index f949ed8bfd9e..e02405a24fe3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -373,6 +373,14 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_devi=
ce *adev, int hw_id, int n<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;}<br>
&nbsp;<br>
+<br>
+int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_i=
nstance,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *major, i=
nt *minor, int *revision)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_discovery_get_ip_versio=
n(adev, VCN_HWID,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_instance, major, minor, =
revision);<br>
+}<br>
+<br>
&nbsp;void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct binary_header *bhdr=
;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.h<br>
index 02e340cd3a38..48e6b88cfdfe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h<br>
@@ -32,6 +32,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *=
adev);<br>
&nbsp;void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int h=
w_id, int number_instance,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *maj=
or, int *minor, int *revision);<br>
+<br>
+int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_i=
nstance,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *major, i=
nt *minor, int *revision);<br>
&nbsp;int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;#endif /* __AMDGPU_DISCOVERY__ */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 9492b505e69b..84b025405578 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -287,6 +287,29 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_=
type type, uint32_t vcn_instance)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int major;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int minor;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int revision;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if cannot find IP data, then this =
VCN does not exist */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_discovery_get_vcn_version(=
adev, vcn_instance, &amp;major, &amp;minor, &amp;revision) !=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((type =3D=3D VCN_ENCODE_RING) &am=
p;&amp; (revision &amp; VCN_BLOCK_ENCODE_DISABLE_MASK)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if ((type =3D=3D VCN_DECODE_RI=
NG) &amp;&amp; (revision &amp; VCN_BLOCK_DECODE_DISABLE_MASK)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if ((type =3D=3D VCN_UNIFIED_R=
ING) &amp;&amp; (revision &amp; VCN_BLOCK_QUEUE_DISABLE_MASK)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;int amdgpu_vcn_suspend(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned size;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h<br>
index bc76cab67697..d74c62b49795 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
@@ -280,6 +280,16 @@ struct amdgpu_vcn_decode_buffer {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pad[30];<br>
&nbsp;};<br>
&nbsp;<br>
+#define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80<br>
+#define VCN_BLOCK_DECODE_DISABLE_MASK 0x40<br>
+#define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0<br>
+<br>
+enum vcn_ring_type {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCN_ENCODE_RING,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCN_DECODE_RING,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCN_UNIFIED_RING,<br>
+};<br>
+<br>
&nbsp;int amdgpu_vcn_sw_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_vcn_suspend(struct amdgpu_device *adev);<br>
@@ -287,6 +297,9 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);<br>
&nbsp;void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);<br>
&nbsp;<br>
+bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum vcn_ring_type type, uint32_t vcn_insta=
nce);<br>
+<br>
&nbsp;int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);<br>
&nbsp;int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeou=
t);<br>
&nbsp;int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index 798b6b4d8f46..c3580de3ea9c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -85,16 +85,18 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ri=
ng *ring);<br>
&nbsp;static int vcn_v3_0_early_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;vcn.num_vcn_inst =3D VCN_INSTANCES_SIENNA_CICHLID;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; VCN_INSTANCES_SIENNA_CICHLID; i++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vcn_i=
s_disabled_vcn(adev, VCN_DECODE_RING, i))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.num_vcn_inst++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.harvest_config =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.num_enc_rings =3D 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 h=
arvest;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;vcn.num_vcn_inst =3D VCN_INSTANCES_SIENNA_CICHLID;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (=
i =3D 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {<br>
@@ -149,7 +151,8 @@ static int vcn_v3_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN=
(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;vcn.num_vcn_inst =3D=3D VCN_INSTANCES_SIENNA_CICHLI=
D) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;vcn.num_vcn_inst =3D=3D VCN_INSTANCES_SIENNA_CICHL=
ID) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_sriov_vf(adev) &amp;&amp; adev-&=
gt;asic_type =3D=3D CHIP_SIENNA_CICHLID)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id =3D AMDGPU_UCODE_ID_VCN1;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw =3D adev-&gt;vcn.fw;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;firmware.fw_size +=3D<br>
@@ -319,19 +322,17 @@ static int vcn_v3_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =
=3D &amp;adev-&gt;vcn.inst[i].ring_dec;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;sch=
ed.ready) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr_old =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_dec_ring_set_wptr(ring);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr =
=3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr_ol=
d =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_dec_rin=
g_set_wptr(ring);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.r=
eady =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (=
j =3D 0; j &lt; adev-&gt;vcn.num_enc_rings; ++j) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;vcn.inst[=
i].ring_enc[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;sched.ready) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ring-&gt;wptr =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ring-&gt;wptr_old =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; vcn_v3_0_enc_ring_set_wptr(ring);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr_old =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_enc_ring_set_wptr(ring);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -1298,8 +1299,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t table_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size, size_dw;<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_vcn_ready;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmsch_v3_0_cmd_dire=
ct_write<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; direct_wt =3D { {0} };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmsch_v3_0_cmd_dire=
ct_read_modify_write<br>
@@ -1491,30 +1490,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 6, check each VCN's init_status<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if it remains as 0, then this=
 VCN is not assigned to current VF<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * do not start ring for this VC=
N<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D sizeof(struct mmsch_v3_0_ini=
t_header);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_loc =3D (uint32_t *)table-&gt;c=
pu_addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;header, (void *)table_loc=
, size);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;vcn.num=
_vcn_inst; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; is_vcn_ready =3D (header.inst[i].init_status =3D=3D 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!is_vcn_ready)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;V=
CN(%d) engine is disabled by hypervisor\n&quot;, i);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring =3D &amp;adev-&gt;vcn.inst[i].ring_dec;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring-&gt;sched.ready =3D is_vcn_ready;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;vcn.num_enc_rings; ++j) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;ad=
ev-&gt;vcn.inst[i].ring_enc[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.r=
eady =3D is_vcn_ready;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C10420624e72c44cc5edd08d93163fe4e%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637595127876624163%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D5MzzuTLBnE5tFffBAMinenV5MVHWOG0lZH3jAnBbvzg%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7C10420624e72c44cc5edd08d93163fe4e=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637595127876624163%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3D5MzzuTLBnE5tFffBAMinenV5MVHWOG0lZH3jAnBbvzg%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442AC284F10305E2C8644FF70E9BL1PR12MB5144namp_--

--===============0529255149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0529255149==--
