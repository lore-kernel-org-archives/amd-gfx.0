Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD17FEE49A8
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Aug 2023 07:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FE610E108;
	Sat, 19 Aug 2023 07:42:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C0510E108
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Aug 2023 07:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwQCbX0rcyq7lz61viS/aGfJc0IXYhNwfrAnNQ1bTu4YK4G/LaLmkLLzCF9QXuEgLReCvEObzMFaWry8YC9yLXQ3tgPDaLB7GFtXIgR7SFq9JI3k5gaz4n26X43dE7FfqYlavo9Qdia+LGsOBOseoV/qOxA/KzMECKKMCtXw0nLYEBsY/YOBe4fbYj7AzGN3cerWJlrp4k96tY2NhM7zl24VfFRTr7VSLi5hZvIGVvVMZJMh5U7LPgcI2d1AN6I9ZuArNJrDxitLf6LusJPHIsCW/vobeQaRPmMjbbvDsvQAbcqQk1zvJVvDm7VLCcKE+TdGNuxRXggyW0KSvVEolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXLZv9XnhppixQqKojy86Fzm1vSmqS9UR1vgFnsfQV4=;
 b=ZNr1SwuwRiit3gvV7Pf3ivbJ3PGm8hkKwfbrcER71DkSspz/H6XernO2Nn7zAtxZO+CLhSv3NkZeD9ZGfPvuG4P1Eokw0MZWm0ZcYJdMHfSVHzHRm/JBrmkLsrfkR61QodUkHGFgFxkaFdSRNzHPLA1RoyII5DXmUsWzd14PrBP9bSf40Gx0gyXL+WDQcwCtTsJnFrtPH0UwXoUWTKYGrEQkMCJcU03ZJygrqlImzZRYupxma/DhufStiYyIKotMxa1wGCoU5fTg2nDvme8PeafVDUX5lQMSCERls8hUtffC4rBlAU8V7348BUH8V8pzxBbBxzaJ1VZeKF4iTW9KrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXLZv9XnhppixQqKojy86Fzm1vSmqS9UR1vgFnsfQV4=;
 b=Pa797+4BVROuXHLndbTSKSTiyaPW7DL8/yFnyYmO+O03SOwbUtrzZR1gXn31polidOPsYlbSQu1L0LP0GBnle1au4bR/CIzuAwRMuDI5/rDJrUEYAxoFDMpuZUrRPQu8Ngfx7IC/NFeCGTqMPz5oNQ7NfeLuw2WnNZPCHw5GY4A=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Sat, 19 Aug 2023 07:42:08 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4%3]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 07:42:07 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Lazar, 
 Lijo" <Lijo.Lazar@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix the return for gpu mode1_reset
Thread-Topic: [PATCH] drm/amdgpu: Fix the return for gpu mode1_reset
Thread-Index: AQHZ0mgimIXwhgwyCkWf55Rq/H6ZNq/xPFZw
Date: Sat, 19 Aug 2023 07:42:07 +0000
Message-ID: <DS7PR12MB607161F9E97A344F1107B6C28E18A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230819064051.27866-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230819064051.27866-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ae0ec8e3-26ff-493a-80ce-6614e846d6d1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-19T07:41:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CY5PR12MB6645:EE_
x-ms-office365-filtering-correlation-id: 1b83afc4-5ae6-41fc-9d3f-08dba087ca35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oLwoSTE8+stfiTOlhHyX9fcivTqxIwNQCmC+88J4+Ul+iQeCS19/tUny+hOnlH29iiyeeWC+NXqh2VYpkZ1w1fTsyPhpx+imwZjYpvd/WZT+avKmGj/10yVrym4+0NeZ8Q9sBBiBxLJ1YguIBPDrHLJD/fi7x+xw2JYc5dKceLiI77Nt1dmBgu8hG5O+/wgn+A/pyo8pqEGEFM3NsPohDKoBEGZ6AoJmVLQcVVIX9LHiaNYn8Gmt7Smdwg2mr9PI0j80ix0Ov18DOs/Hi+CVI82UReK6YscfikosSc0jKtPLu9GTo7uo9FpLAiGoVBmCQv1zT6EKyRglQUSCs4EKWfT8iCuVAkYfmqJtDEbMQYWvMpX4VWPMc/DT1D1IY0qjS6xMyK3GmcYPLPYdARHp21skklXwIG0fnqcOUoN6HVR6szD8u4Ge2A26O+2XrxEKBlyUcQ+/ti69XHZMPuUp/YNUfxpdNruAyObT6LQN4zOWaBjUqKGZvb5yLdAMa3dLNFMJGvOZDLf5WALS+Hrr8GeHqWlj7717q9HbBCXXesgy9GxWHJADjIB/FP0N+clGhPAwFmlFE3YdWa2h4Rzan9NCDnOcm/g01DZk2t/WXo5J58+nubSfAbnokYlDd48f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199024)(1800799009)(186009)(86362001)(76116006)(110136005)(64756008)(5660300002)(33656002)(41300700001)(6636002)(316002)(2906002)(66946007)(66556008)(66446008)(66476007)(8936002)(4326008)(52536014)(8676002)(478600001)(71200400001)(53546011)(9686003)(38100700002)(38070700005)(7696005)(6506007)(122000001)(26005)(83380400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nc3K+QN0uOO5bG0gFpHtfjtDIHitvN1SUytvqRMI+xz7y43uBj2RyUtGmMyl?=
 =?us-ascii?Q?FCXxfKWn8oq6Y3sDsBgU5FqaA0dZeqen5FEokFoi1HPmtUB6D1/llRbHEh0e?=
 =?us-ascii?Q?Io6hC09bi1rUIhNsIUPKYW+xxmY5AR/HK5dV/it9X7u1HWdzCHkLVibAqZ/T?=
 =?us-ascii?Q?a6RwPUGYmx8p5PoH0HTevmMInQW39ygIADTd93ndjTkBB8TGx6dQj1cEwCdE?=
 =?us-ascii?Q?8a7wTysYrtfaMcxHjMsXoIgRc5cTBRZkMJqcncic51HoqFXfEzFP0oH3yTaV?=
 =?us-ascii?Q?3GuzvmTJgQRS5k64ql4BWmWw7KszohwSJ1Z8V1SLgdYG7XLH1WTufa+ep3Ju?=
 =?us-ascii?Q?BHJT07bpihU2khIreJJdWrJRPFM/0B9OgwJnO3E7GjMCGhwsvVpPyU1+HI67?=
 =?us-ascii?Q?83MLnzxQaONYp39vdEL84quOagVrTR0FVPuKCNkPKbfnpb925qt1IJaQTiUM?=
 =?us-ascii?Q?zc0fsg3BFIUrOY8Mae65mtxOgCaxbrQxLeEs1mIp7RJSn+haD4DEWYzaHg+S?=
 =?us-ascii?Q?Xfi+CE1KdUA9oGkJrQJdZSaCIcsLUQhZvRHmCioWI/qpz2SHWh6sNhF4hBTS?=
 =?us-ascii?Q?zi07WyyBeY4KJTRLFCKx5rvbji/sFOgRyHssaD3ddJUd3ZF0G7aIf9pigWvm?=
 =?us-ascii?Q?/UDnNNBNhqe8fUmzSJt0O0dbDJJFWcic7E59AhT1/GE2vhDIQ8Zfbr2iUcJN?=
 =?us-ascii?Q?GU4WiAThkKamNncIcO8Rbvs3mmglxzwlPG6AIosvrI537Cq7xJQEcWDGXdx4?=
 =?us-ascii?Q?U3fOhvXWjvTyWrbozjmCq1gwtTdB5LCVwiulGa0owE1ute34WUR3XVqKcHAx?=
 =?us-ascii?Q?3a2n/ymbRO0KMHVVdY/f5H4W3x7bGMIYI8NPgsQgV+xX5EHeDNNz4XkRZz9Q?=
 =?us-ascii?Q?3QazH/aUVaxxHDItA862VcTEvu4v/M9ypDjspxpqh+ZcHZbxRzN8gCcmJA1q?=
 =?us-ascii?Q?vlk615Pl/5hB0l2fZxWcU93DxSmAIirbJ155wgvrUifOwNzIpZCMHwiNV/Mf?=
 =?us-ascii?Q?rZhcd0cUheQ1NAhOG7jkFhfdx5qWq5GiehTsKNj4LoIYEUi5tYbjM5DSnQdN?=
 =?us-ascii?Q?/IZ8gI4KdVTamJBlwO2VsPNu+zIHGKOsjbrEKfLTlnBsRzwyav7/Y2cOztGq?=
 =?us-ascii?Q?t3deW7wV5W92oc6ILjZke2H/AlL4YKroFcqi+X5u8QRgqTXJWmqldNLxzE8b?=
 =?us-ascii?Q?N3F3HKrWZJZnRxMPULOqgxV0lGD2SEz8jEWMY+nQ9iUAXAqx/js8tzz/TInQ?=
 =?us-ascii?Q?mmxPM8/s4cZOuY70dDPjZjKewNRL+c09R/KlBXsFSbOKELfEbQ6L6XqIDQXt?=
 =?us-ascii?Q?XOsZa3mkqqLvU7s8fSHpb+0Wz+e/iXwham2PVbZMoPIx8VcF976/YQUWWx1i?=
 =?us-ascii?Q?j29wTZaXLMGLfeSD8wmEnF0zCePZNQgLpfZOfSRakLdCZufpN+/AB+lz4t3v?=
 =?us-ascii?Q?P4EaAJQZ/AehQ/LWHCwAPv4VaOWMVXlu4011uT7aXgt7EjLN1tRL1Q+xEq4G?=
 =?us-ascii?Q?+C7hd2xJuCXdPXlr5dLmCCC3MBJKpK94EU7lQyDNHSkmU1SC6KX0U3/o+imt?=
 =?us-ascii?Q?CUh6sBA8EtCR2n+TlTE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b83afc4-5ae6-41fc-9d3f-08dba087ca35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2023 07:42:07.5981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ih9lsnxiduyaPwHjvoVtlAozotsPu2Wi2CtE1iiZogPLOgXFjYS8dSmhieAk55l52Y0/z+T1A/3UBk0HinQFHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Saturday, August 19, 2023 12:11 PM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Lazar, L=
ijo <Lijo.Lazar@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; K=
amal, Asad <Asad.Kamal@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the return for gpu mode1_reset

amdgpu_device_mode1_reset will return gpu mode1_reset succeed (ret =3D 0) a=
s long as wait_for_bootloader call succeed, regardless of the status report=
ed by smu or psp firmware. This results to driver continue executing recove=
ry even smu or psp fail to perform mode1 reset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5586146b8c76..533daba2accb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4701,12 +4701,12 @@ int amdgpu_device_mode1_reset(struct amdgpu_device =
*adev)
        }

        if (ret)
-               dev_err(adev->dev, "GPU mode1 reset failed\n");
+               goto mode1_reset_failed;

        amdgpu_device_load_pci_state(adev->pdev);
        ret =3D amdgpu_psp_wait_for_bootloader(adev);
        if (ret)
-               return ret;
+               goto mode1_reset_failed;

        /* wait for asic to come out of reset */
        for (i =3D 0; i < adev->usec_timeout; i++) { @@ -4717,8 +4717,17 @@=
 int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
                udelay(1);
        }

+       if (i >=3D adev->usec_timeout) {
+               ret =3D -ETIMEDOUT;
+               goto mode1_reset_failed;
+       }
+
        amdgpu_atombios_scratch_regs_engine_hung(adev, false);

+       return 0;
+
+mode1_reset_failed:
+       dev_err(adev->dev, "GPU mode1 reset failed\n");
        return ret;
 }

--
2.17.1

