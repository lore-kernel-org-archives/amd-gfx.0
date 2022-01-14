Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB43C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 06:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F30F10E596;
	Fri, 14 Jan 2022 06:57:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C94210E59E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 06:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f34+5iBE0h0FD3OzQeZEo5z/olnoBo1UQxsslHWyepbHlV7IbSC3nwQNUsmZdrvJt5hTZt1iA8ncRs/GoctwM+yucbbwlyub+Tk02uBnSwuXi+S4qZcwipmL1OSqCZ+Y+UFfjsKBzMl1XMd/MsJbKJURk640TvNIW0K9q70sFtpnjeEWi0s3e4mz3LLsy2hVNi0kAieasuM45omQOkNawOdIUulOlrcmx5YGojYxr3NLcLfWAbouVoGA5Ps2HAsE3ULlDoyE3VmqTZ1T/5T0F4farK32LrPqhBddpNPY8EHO4zk39eH/+79Sl/2LKT+pTsEr1C9NJV3vjycmFsjDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLiMVZ3g7Fvu4Rl86oior4HdkZa9yf9gi8UvkUNXnic=;
 b=gZXreUSqA4d+G6sLMPC+xp28V+re7KRFGFyEArl1PWs3+rKxmj2I7BSnBNU777HuELQYEUhU2VWd76odkmDZr8DG3+Z73kuz4eEtge7HZXOYvX6xDKQhBQrrVW/CerXGTG2GXb2P7WYZQ0MF3hWADD8Ih0cpksWAbsG6/ngNdedkejtnMqnQgj0PLJQtpS38jzcNmtCsJckbs6yWlgz4KM/UMfAEApaOLZkJ1Of9BHOyatj4Mocq6heUwTLcg1qMAKtbZaySldkCMwmotYIdg2nQN9H7bDqN0GLekvjAV/hbm4oA7b2u/AlBGFAb+wNBWCCqJ+3A7wrZ1LyClzKz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLiMVZ3g7Fvu4Rl86oior4HdkZa9yf9gi8UvkUNXnic=;
 b=gtYT6ssY62gxH3sh99gNFdYnINGLZJu7FfBBUv9fJ1Cn2mC8h8Qwy4MbESzmf9t0lTwjGBREhEhiBLRTT+eV1H26Aod/ttx6BMP+9xxCtxZcUTiQ+Nb6tQomDnGDsspww/uuJcsXQWPzY0l/yDfGKZLKIGt5HGgJK2ft9pu0gyw=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM5PR12MB2565.namprd12.prod.outlook.com (2603:10b6:4:b8::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 06:57:13 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::588b:a97e:eb3c:8dfc]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::588b:a97e:eb3c:8dfc%5]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 06:57:13 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV
Thread-Topic: [PATCH v4] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV
Thread-Index: AQHYCROefUB7gwlEr0e5Vi+mvUdE2qxiFR/A
Date: Fri, 14 Jan 2022 06:57:12 +0000
Message-ID: <DM4PR12MB5072DC47A85FD3975027CE77E1549@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20220114065418.130056-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20220114065418.130056-1-Jingwen.Chen2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f942953a-dad3-49d0-9c44-ad3ce2b7b9c5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-14T06:54:55Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9702d7d-190b-4141-7e1b-08d9d72b17bc
x-ms-traffictypediagnostic: DM5PR12MB2565:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2565E3066C8C824527A32351E1549@DM5PR12MB2565.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LOL8MGrYIleE68mpqkoxsYE9qnr0nW8KO3iWIPBL/Et5F5UfK6i5AXPNV4f1RAvS+kfidatoCVhLw28+EoIeFlc0jWCqe2os15efidNr+kliA1AUkFQz1Bbtx/SSGHe9a+egOqx3am3YkJf11MLlrxBRGNd5S59Ho3YLbIlP2AJlCD5e0aTxLBLPGV5z6bN1rG8Og2OYsAhS8GuhlJoTfLWOkGcyst8UGzpp6Cgm5b5WicW1K0CvLkyENCswY3ffJ/Ks8NtyznAx24EfbTuUqKlS894Ap2pd7TlD5IecxHYDrxFisITxhPNZz5427MkFFEzZe+fHqM6EiAQrIX+NhTNWgqqHwfrTWSO7pYcDgJpaD+W0xA7J4URyTtMUntDnM6mT48E2R2CXUG+xBwfS7vckOp2TIvjo/dOUWaKqO/joz0uEN4SqeZFtyM0epIlG2Z0nBLvCInMhh1+4Wu4oPkztZrJJG9XWV6wOAo5HWItZ4WqgtilHvQFRdiz7grZB3uk+g6eTX3KQBemcDNei7jm2Kmyk0U6RPuJrdvk9ZUPXjDY5rDiADfkUVrRngZpV49JFAAMql1z5k0NtrWqjdvl16AcXEGM3FPPsC1qmhpQg2RgL5dDb3Pkhiewjbim3w0qQVpCoSJXZXc8ZvHRW7XNhvCfpaNSfNVz1CgjABP/HJhg9woA94p8UIDD4j0xwivhx1kVbhCApoRegQwbXLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(5660300002)(33656002)(7696005)(9686003)(38100700002)(8936002)(83380400001)(26005)(316002)(4326008)(110136005)(66446008)(6506007)(508600001)(66556008)(76116006)(66476007)(122000001)(66946007)(71200400001)(38070700005)(55016003)(2906002)(86362001)(186003)(52536014)(53546011)(64756008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OfBErkcFRY8X0XQyIth7GUl7WMJsNe03vzmfcgJNmaplYiWXufXM+SdFqOk2?=
 =?us-ascii?Q?1iP2+O9DucDuy3uaEG0nOdLfNt0wf+DoyoZo4edB12cRUmkPt+8MnPWJccjE?=
 =?us-ascii?Q?4npzqT2H546HIeGRPsSUqEjV8lu1+GGLdVb8GapaAuM/ySGEx/XkbDkG/TM8?=
 =?us-ascii?Q?DIBpVGu6cN29VxK5xSE8o4iuHL+Kyzr2prmiz8IIC+c9P0UfXf9xwn98MoCP?=
 =?us-ascii?Q?WnhWhRXwufDiSHJGxrzcu9yCJ4hlNnFuUvQigwISX3p1+EcPw3/INlxn8bQN?=
 =?us-ascii?Q?pnWomyAnsujm+6kCdJU5ArQPGbDF/unxKsbZ3sAZ5iyVAC3VOy1dE1bDk2ih?=
 =?us-ascii?Q?yZi7xqke+uMEfuBeTgopJk0gm0KljFrMFFvF7t1IsTiKmXB/U1Z6RRSnp+eI?=
 =?us-ascii?Q?OQc8tgO6zKXTRkEVjkdqwDYlSpzkW3BC+RtpUpuqLerauYXjiQ5JC+zRP6uD?=
 =?us-ascii?Q?alr+OfzO3fZjtC9i83ovb6ZxDw8mLzU8sNqzKrHOSjA0qT2R4Pq9L4yP4lkY?=
 =?us-ascii?Q?Y8FFJoD8dxVM9r0+ZOreirOq48SHetz3fsr5cxto9CctEbX/zUEgquFA8Uo0?=
 =?us-ascii?Q?8rW69piWF6uXqQxbkBzVg0TDWFHbUA4ykBKEYi4TXivwxzoDPuQuOoiCNMNb?=
 =?us-ascii?Q?cIyQD0/zlmxAjvgcJ8sl9OQyq6evWrK1eRc/LsOxDFvuO+xXlsbWScIxNWtL?=
 =?us-ascii?Q?59KGnhgnsRumLG4Pi6lXR4C8b+XZIkmaCfU+ye0q4RYws/x1HllADV7YBTI3?=
 =?us-ascii?Q?p+B1iNIrCUGjW5nUaTPXPQnftlGs9rAhV0QjWLBx9PjkdZoW4I/pYV1vAn4H?=
 =?us-ascii?Q?DGlEssQPFxNl5vFkOVkbVWSoE+ptETpKJyqCtML3ewdSSYhfIO0ZWSXVWTH5?=
 =?us-ascii?Q?a6jXClKO2cgYkhBFrswuD6+1WF6zYIoukSnG8qV3vYIus7zQjQzdTSXGTJg7?=
 =?us-ascii?Q?woVdBs/tnH6scYtrXMhpyrQCFy4HU5EvcvN15uePlms/BkUfLxJfn5Wck9hh?=
 =?us-ascii?Q?qd8s636r+LbZ98BY7GeCcVZBkC8JpBi32gi/aSzdjqeGfP+VU7S7h33KLHqR?=
 =?us-ascii?Q?AoMuqv/K+b6j5tpkpK/CfJExnLTtOkcawoeuQz0UvNyK7aDDSx+R9ITgMAM9?=
 =?us-ascii?Q?pv06KWf/excKzumo2z5M4T1qYME9hrd0bIX0xTc4FNk+mVAoQ0m4jKM4vPJJ?=
 =?us-ascii?Q?p+K3/r1zFesNmEcM6Djmc19BtYSblJLc6HOiS9yi2uFIa2j9FAcwv8emlA3W?=
 =?us-ascii?Q?De1tQw+Te51U4bLku9k9he+MeTHpEdjBVSSKWKtjUC8d0wXbBX3rzr03MWds?=
 =?us-ascii?Q?tZaiYC7Lm6d1AkpPvxz1hqS49pQrF1aJivNmZJMeYTpoh5oWrKvpKhZac9hE?=
 =?us-ascii?Q?226znoKJrblr0WcxFvQmNihzgY/0AjW7lv0qi6OzTCEkVK/izfYj3Ib2fvBo?=
 =?us-ascii?Q?YH5YmEIioK2ehJrT+cmseQsyybrYXfRaV0E6ZJUk61TQANLfer4ib+XZl9Y+?=
 =?us-ascii?Q?r7cgNYPdzJqVCGK7AeavQTpziM5TzXHbVM1Rp+ltWjjzduShXhYeFZqs0suB?=
 =?us-ascii?Q?pR108GzX7MCl/dbtyg8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9702d7d-190b-4141-7e1b-08d9d72b17bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 06:57:12.9868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jksSlBMKULRjp1QCKhxk1x45W1G7SoAW8Ha6RnQqrBaiT+w9DxgBII4vvZB6THQd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2565
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
Cc: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: Chen, JingWen <JingWen.Chen2@amd.com>
Sent: Friday, January 14, 2022 2:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Skvor=
tsov, Victor <Victor.Skvortsov@amd.com>; Chen, JingWen <JingWen.Chen2@amd.c=
om>
Subject: [PATCH v4] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV

[Why]
This fixes 35709bd76d229a51b0c571a768b741650ec47828.
we should read pf2vf data based at mman.fw_vram_usage_va after gmc sw_init.=
 patch 35709bd76 breaks this logic.

[How]
calling amdgpu_virt_exchange_data in amdgpu_virt_init_data_exchange to set =
the right base in the right sequence.

v2:
call amdgpu_virt_init_data_exchange after gmc sw_init to make data exchange=
 workqueue run

v3:
clean up the code logic

v4:
add some comment and make the code more readable

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index da3348fa7b0e..5610eae8ef0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2353,7 +2353,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)
        }

        if (amdgpu_sriov_vf(adev))
-               amdgpu_virt_exchange_data(adev);
+               amdgpu_virt_init_data_exchange(adev);

        r =3D amdgpu_ib_pool_init(adev);
        if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 894444ab0032..07bc0f504713 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -625,20 +625,20 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_dev=
ice *adev)
        adev->virt.fw_reserve.p_vf2pf =3D NULL;
        adev->virt.vf2pf_update_interval_ms =3D 0;

-       if (adev->bios !=3D NULL) {
-               adev->virt.vf2pf_update_interval_ms =3D 2000;
+       if (adev->mman.fw_vram_usage_va !=3D NULL) {
+               /* go through this logic in ip_init and reset to init workq=
ueue*/
+               amdgpu_virt_exchange_data(adev);

+               INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_updat=
e_vf2pf_work_item);
+               schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_ji=
ffies(adev->virt.vf2pf_update_interval_ms));
+       } else if (adev->bios !=3D NULL) {
+               /* got through this logic in early init stage to get necess=
ary flags,
+e.g. rlcg_acc related*/
                adev->virt.fw_reserve.p_pf2vf =3D
                        (struct amd_sriov_msg_pf2vf_info_header *)
                        (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10)=
);

                amdgpu_virt_read_pf2vf_data(adev);
        }
-
-       if (adev->virt.vf2pf_update_interval_ms !=3D 0) {
-               INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_updat=
e_vf2pf_work_item);
-               schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_ji=
ffies(adev->virt.vf2pf_update_interval_ms));
-       }
 }


@@ -674,12 +674,6 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *a=
dev)
                                if (adev->virt.ras_init_done)
                                        amdgpu_virt_add_bad_page(adev, bp_b=
lock_offset, bp_block_size);
                        }
-       } else if (adev->bios !=3D NULL) {
-               adev->virt.fw_reserve.p_pf2vf =3D
-                       (struct amd_sriov_msg_pf2vf_info_header *)
-                       (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10)=
);
-
-               amdgpu_virt_read_pf2vf_data(adev);
        }
 }

--
2.30.2

