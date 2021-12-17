Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94071C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 18:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C5410F48D;
	Fri, 17 Dec 2021 18:37:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B10F510F48B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 18:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUM3i6wnspbje7nCy8iNzTyY18DMzpCXYe4GbDxNjzl1oPObmL3mNJhf9PChLzXAiQUzcDWTkcvQS8D5d3p7dlUWOemB2YpC6AjX5LKamyhdWRn6e8vf06QKR6CQXBIY3tAd7Wvz94Dgw55DmRdmgc12GnQ/g2k1PYY0iKzhIrGGOaV0NDKuIrZEJ2RWBQBRfcfqBq8JeD8AAdRAYbsHwMXuqpeKkrSll1uRzVy4ucQhfnL+9ho2NQ0XInZpLn8/AV3dRjOuT+do4Z9iv4LVG2tG6aBNlbM96bvFlUG5WNPFbmPUb8kbep8FUcF+7MrxjSlbhFws15HKI08xvyJJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuQlT4x5pX7CE8ToTyUg3S3FYUhdC9ROZN9JOjpLM9k=;
 b=Vk602T5XHaRKoynNA+KZQWVPCRBMuSna+ytuZMvc4R/sSM3kAxklNQoWvvXEilNLnUFRI0UvqeHOcmcQPI1ztgJ2kmSUnL5xz9he9z1mXF1Wm8C78bkYz5NAg5TD9a9ubf50JcRi1yivMpoVL404L9wVciOE1BuMZDENQeAgU8ZWq7KNpiFjcq2ZvE/5ax58/gI4STGT6EWFmZRPiz1ch8dfmQqXU+GfwmtISuJschUTLqRqZktmUQp+Is7Gim6re9hjIDNMkgElR+9Dcb4XX439TMyRH7CEU9dzJ9ColPETRtR7g3CdgWPc14jdRosFSo32eav+LLklhcC3xrJtZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuQlT4x5pX7CE8ToTyUg3S3FYUhdC9ROZN9JOjpLM9k=;
 b=HxdAVvFCJgyFW1HNOC/lpJPaD/3ohN1R1wR136441680WvI64HwWVaxA6CPUPZ+yBs3dFqXqn6jLznNM+rdLyd/Jst+7nK33otTxmJAV/EGpdkcxT/EyQvlPmJf/p6OQRv8nYnxKrBESj8NN6VYx74GcnC7LP8GHW7v++KqLDoI=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 18:37:36 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4778.017; Fri, 17 Dec 2021
 18:37:36 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Saye, Sashank" <Sashank.Saye@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Topic: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Index: AQHX83KUPa/nDJ5+hUGQIwEnFR7rJ6w3AL6Q
Date: Fri, 17 Dec 2021 18:37:36 +0000
Message-ID: <CH0PR12MB5372BE5474A9F08CD247FB6EF4789@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211217181833.203229-1-sashank.saye@amd.com>
In-Reply-To: <20211217181833.203229-1-sashank.saye@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T18:28:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=94d25861-dc53-4c3c-969c-8ad04b714738;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-17T18:37:34Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 63fcf915-9568-4b92-908f-d3df341f63fa
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cb4e675-407d-4598-c56d-08d9c18c4c3d
x-ms-traffictypediagnostic: CH0PR12MB5297:EE_
x-microsoft-antispam-prvs: <CH0PR12MB52974734BBB93FE0F63DF064F4789@CH0PR12MB5297.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+hsEBxMESyGec0GVQ39rJJpLqapdVuZRT7CTQGIByZok6zl946GVjjlgxIEhi1LC6yDwnsX4tFy84oiz9ZmXCUs1mK/xp9i0OVS9Ggz6FAfyqZAzxJGvxx5u/Tl5CGmdcrybZCdxXvDobqM5ywGUw1T/LPjwwCl5tGv9RHX547Zfxjt0FnMX8re3e7+aGwTVQ94/ZygYOeG1phZYWPPbMGnPDVLEODgIU5gaBOyTulgQYAqgMiEj6BAmBNHGaOQcOtg5Q4Z7tBtUn9GvVonGSqPVhBv1Wh6jQRXMDeqB/ct1EwpzlMRTK1u6ROwstKZHV7RJgv7pKNi0FLbKMJes5gW6z0xKyUWb6Vz/qTx+slEkxP+RvPlopXncN+yLLHyauyfR7M4PSUYF9JaTMRTNPYmUAetlz9MSvq83h1KoZ7dfpr5S9M5qSmLD3vdQdVn7shCGYK+5TJuHgbDAaqtlVq6K1oGRy2V9DzUI110yC+snCYWqwVSeXBPVWOjW8ydSfvWa2BNzElwT6NgEd6ql//57qUBmvEKGilKtCwt0FQ4NPs5AwDiaPOHUOhrqU8aBONPmECtOemP6bSwTQMBnzacPcgDwSiolsCQ7ROXHkHe3HZO4OFZBHv1dozu2q7aPV0Ojo4P50QWGeQx/KgK2gOkPUsIt2eqqY/HSrCeOg1tA0hvaTLoOtDn1rlArK97XYnxzVJvjX05ZgXVGjOv4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(15650500001)(76116006)(6506007)(53546011)(316002)(66476007)(86362001)(66446008)(966005)(66946007)(508600001)(64756008)(66556008)(8936002)(110136005)(26005)(7696005)(8676002)(186003)(2906002)(55016003)(5660300002)(30864003)(71200400001)(33656002)(38070700005)(9686003)(83380400001)(38100700002)(122000001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KVJHdMM56FRnyHDl0qf9zHFpPAm4YByjphiNLVStG6BJ7gj/0WROUVLv0jKO?=
 =?us-ascii?Q?F1ZzrGbJ0lrQEHD/F8EE6uNCc2ZmIx96/2UevcuhN22FSfe0LA5/ISpF8MZm?=
 =?us-ascii?Q?wvi0UTPttUWKkjOFrqt78fsSpzLCFpAcukTEDNbw9c/LrMvEtHnYpfZRBeBJ?=
 =?us-ascii?Q?ZVUpplHKXbYtM0A/wmPttTmqN5hBDtz6TLKal3KRxEEbpRtL/cR5F9wbni+/?=
 =?us-ascii?Q?f4EAAL6Yj+6kBAnXCYY0hr0ZYLuz38wi+jdPkfS1bg/VeswS5pauRgmOwRNM?=
 =?us-ascii?Q?zseL+gtGznYopzj2ZzmIcImwgyohxebsZGPjK+WMLBibYPP6MsLI9VcuAH/p?=
 =?us-ascii?Q?gwKjnmqhobyUIMHP+Wbvvcc/ED8/Ways6ORa2tFXi/jsgiU895aV26PYoTpf?=
 =?us-ascii?Q?hIjLnyO51U6B2t14JysqIJMxV2u1EpRsotioE8SR0e/bDNu3zBhmvW9CYlHe?=
 =?us-ascii?Q?x986hLDOW37rcZ/5lRToAbWr4BTkc1z0SJBREFMyLxJ/sn/fjo8U9Qid6jm7?=
 =?us-ascii?Q?pc+7+U44gAJcZvhUYi/KcaCK5PD+PlbLWaIMXeMI5wpz6FDvdwE5vWFjgxm2?=
 =?us-ascii?Q?FmtCl7lsn0YSSclNGd17NgCVIS01OrOiGPSoT+p6cOuWmCMrdnT1oJxscJSI?=
 =?us-ascii?Q?0XmXoX5RMNxGyVr8J/1uuZBfLMUvIW3i304Z1hNhn73s+G4QX+3sqK2rW1yf?=
 =?us-ascii?Q?1d4UudMj7w98E0QOasLqLTbaJS0ppADqxGcJl5xrHqJGOhMxsmH/8OJWbhoR?=
 =?us-ascii?Q?9D8nBOsLu0kVYy/xcmejOm59T5O0IhxDuTlZVKbg2/7TIoAa7h5FfrG09NGG?=
 =?us-ascii?Q?oaTeVQcmevZYCxC0G87eVSejGWSUWSNH4ersqQkNaYC7cncmXr80XjALCuLJ?=
 =?us-ascii?Q?es7g+UZzZnt8IMM3eHpx5kGaGTkhTbCviy4LtSSHx8T4NCp086qua5VB9BQd?=
 =?us-ascii?Q?iyVoFVh09/QfoaAE7BxVVh/tHjT8OvHBZH2n4LvmbAnaIoxzgmKynbYliIzq?=
 =?us-ascii?Q?LhLlsSlneUmCCbOEKJifJMyuHRq1g8Nmu+GYTtpMM1lHMK7G4rwWeJ/K7oKr?=
 =?us-ascii?Q?rMHO0yBej0Zp9ZMWQhoRQBqZhSQsW2CLQPUXDrwA1ifvMKkV+0KOiZ7MvFVf?=
 =?us-ascii?Q?mOgQNtblQanskKY/vnQue2livBKucAt1KvkJkih5xyua1pvjv1EVaduMMvZZ?=
 =?us-ascii?Q?jKT/Dsr7WPTTgPphDLDuAMVcfFBquPL/RPGakqubgP5aZrUj79PoBuyRi8iC?=
 =?us-ascii?Q?8dUhjefBAejzU6Q23ASBupcLsk4h3RX+23EdpjaJUENdZiDT5xecN6g2wpT0?=
 =?us-ascii?Q?dvbJNnc8vwLa5E1nIhUeRxBfNoz/63aNaxpQNVnwy8dS+t12cMfpS6733F8s?=
 =?us-ascii?Q?hn0tunxN0Z00UBUaI3hOgwEfGxCGlC+anWPkTb6lifGUcl1ZJTXGeInLvomb?=
 =?us-ascii?Q?xbFbkUxUc3Il5yBlIIa10Djyqo5i+n2uRe/kDvyiaKDZ0GtYOeSTZW41S8kc?=
 =?us-ascii?Q?rDu4i49H0abO5QucxxnHdrFvJSk/VkAr8XH8hofj6t4oYjZxXOnFFH5Cs+tv?=
 =?us-ascii?Q?oVPOphUl07/zyOl6I+m5K0toTBE94mZ5LFSQRzKmF3NtdhcWNGpwH4YtAB3E?=
 =?us-ascii?Q?LUgGWJP+LdJcjt/XfC00ra0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5372BE5474A9F08CD247FB6EF4789CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb4e675-407d-4598-c56d-08d9c18c4c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 18:37:36.6801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rtAfUqjedVA7Dn22Bq+TeHX+8AqOwCaUuMb4exAyjluSL1XHFD2psgfgI16KPhwS7CP5JPG0XeZWe9phmd14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297
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
Cc: "Saye, Sashank" <Sashank.Saye@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5372BE5474A9F08CD247FB6EF4789CH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Comment inline .

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of sashank =
saye
Sent: Friday, December 17, 2021 1:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Saye, Sashank <Sashank.Saye@amd.com>
Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough f=
or sbr handling

For Aldebaran chip passthrough case we need to intimate SMU about special h=
andling for SBR.On older chips we send LightSBR to SMU, enabling the same f=
or Aldebaran. Slight difference, compared to previous chips, is on Aldebara=
n, SMU would do a heavy reset on SBR. Hence, the word Heavy instead of Ligh=
t SBR is used for SMU to differentiate.

Signed-off-by: sashank saye <sashank.saye@amd.com<mailto:sashank.saye@amd.c=
om>>
Change-Id: I79420e7352bb670d6f9696df97d7546f131b18fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  9 ++++-----
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |  6 +++---
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ++++++++++
 9 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f31caec669e7..0c292e119f7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2618,11 +2618,10 @@ static int amdgpu_device_ip_late_init(struct amdgpu=
_device *adev)
        if (r)
                DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);

-       /* For XGMI + passthrough configuration on arcturus, enable light S=
BR */
-       if (adev->asic_type =3D=3D CHIP_ARCTURUS &&
-           amdgpu_passthrough(adev) &&
-           adev->gmc.xgmi.num_physical_nodes > 1)
-               smu_set_light_sbr(&adev->smu, true);
+       /* For passthrough configuration on arcturus and aldebaran, enable =
special handling SBR */
[shaoyunl] This will change the  behavior for ARCTURUS, which only need to =
set light SBR for XGMI configuration .  You still need to check XGMI for AR=
CTURUS, but don't do that check for ALDEBARAN
+       if ((adev->asic_type =3D=3D CHIP_ARCTURUS || adev->asic_type =3D=3D=
 CHIP_ALDEBARAN ) &&
+           amdgpu_passthrough(adev))
+               smu_handle_passthrough_sbr(&adev->smu, true);

        if (adev->gmc.xgmi.num_physical_nodes > 1) {
                mutex_lock(&mgpu_info.mutex);
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/aldebaran_ppsmc.h
index 35fa0d8e92dd..ab66a4b9e438 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -102,7 +102,9 @@

 #define PPSMC_MSG_GfxDriverResetRecovery       0x42
 #define PPSMC_MSG_BoardPowerCalibration        0x43
-#define PPSMC_Message_Count                    0x44
+#define PPSMC_MSG_HeavySBR                      0x45
+#define PPSMC_Message_Count                    0x46
+

 //PPSMC Reset Types
 #define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 2b9b9a7ba97a..ba7565bc8104 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1257,9 +1257,9 @@ struct pptable_funcs {
        int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);

        /**
-        * @set_light_sbr:  Set light sbr mode for the SMU.
+        * @smu_handle_passthrough_sbr:  Send message to SMU about special =
handling for SBR.
         */
-       int (*set_light_sbr)(struct smu_context *smu, bool enable);
+       int (*smu_handle_passthrough_sbr)(struct smu_context *smu, bool
+enable);

        /**
         * @wait_for_event:  Wait for events from SMU.
@@ -1415,7 +1415,7 @@ int smu_allow_xgmi_power_down(struct smu_context *smu=
, bool en);

 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);

-int smu_set_light_sbr(struct smu_context *smu, bool enable);
+int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);

 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type eve=
nt,
                       uint64_t event_arg);
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/p=
m/inc/smu_types.h
index 18b862a90fbe..ff8a0bcbd290 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -229,7 +229,8 @@
        __SMU_DUMMY_MAP(BoardPowerCalibration),   \
        __SMU_DUMMY_MAP(RequestGfxclk),           \
        __SMU_DUMMY_MAP(ForceGfxVid),             \
-       __SMU_DUMMY_MAP(UnforceGfxVid),
+       __SMU_DUMMY_MAP(UnforceGfxVid),           \
+       __SMU_DUMMY_MAP(HeavySBR),

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v11_0.h
index 2d422e6a9feb..acb3be292096 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -312,7 +312,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *sm=
u,

 void smu_v11_0_interrupt_work(struct smu_context *smu);

-int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
+int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool
+enable);

 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index af98fa140d83..76f95e8ada4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3058,13 +3058,13 @@ static int smu_gfx_state_change_set(void *handle,
        return ret;
 }

-int smu_set_light_sbr(struct smu_context *smu, bool enable)
+int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
 {
        int ret =3D 0;

        mutex_lock(&smu->mutex);
-       if (smu->ppt_funcs->set_light_sbr)
-               ret =3D smu->ppt_funcs->set_light_sbr(smu, enable);
+       if (smu->ppt_funcs->smu_handle_passthrough_sbr)
+               ret =3D smu->ppt_funcs->smu_handle_passthrough_sbr(smu, ena=
ble);
        mutex_unlock(&smu->mutex);

        return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 58bc387fb279..505d2fb94fd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2472,7 +2472,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
        .deep_sleep_control =3D smu_v11_0_deep_sleep_control,
        .get_fan_parameters =3D arcturus_get_fan_parameters,
        .interrupt_work =3D smu_v11_0_interrupt_work,
-       .set_light_sbr =3D smu_v11_0_set_light_sbr,
+       .smu_handle_passthrough_sbr =3D smu_v11_0_handle_passthrough_sbr,
        .set_mp1_state =3D smu_cmn_set_mp1_state,  };

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 28b7c0562b99..4e9e2cf39859 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1724,7 +1724,7 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
        return ret;
 }

-int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable)
+int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool
+enable)
 {
        int ret =3D 0;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7433a051e795..0e60d63ba94f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_mess=
age_map[SMU_MSG_MAX_COUNT
        MSG_MAP(SetUclkDpmMode,                      PPSMC_MSG_SetUclkDpmMo=
de,                  0),
        MSG_MAP(GfxDriverResetRecovery,              PPSMC_MSG_GfxDriverRes=
etRecovery,          0),
        MSG_MAP(BoardPowerCalibration,               PPSMC_MSG_BoardPowerCa=
libration,           0),
+       MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,   =
                     0),
 };

 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =3D =
{ @@ -1912,6 +1913,14 @@ static int aldebaran_mode2_reset(struct smu_contex=
t *smu)
        return ret;
 }

+static int aldebaran_smu_handle_passthrough_sbr(struct smu_context
+*smu, bool enable) {
+       int ret =3D 0;
+       ret =3D  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, ena=
ble ?
+1 : 0, NULL);
+
+       return ret;
+}
+
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)  {=
  #if 0 @@ -2021,6 +2030,7 @@ static const struct pptable_funcs aldebaran_p=
pt_funcs =3D {
        .get_gpu_metrics =3D aldebaran_get_gpu_metrics,
        .mode1_reset_is_support =3D aldebaran_is_mode1_reset_supported,
        .mode2_reset_is_support =3D aldebaran_is_mode2_reset_supported,
+       .smu_handle_passthrough_sbr =3D aldebaran_smu_handle_passthrough_sb=
r,
        .mode1_reset =3D aldebaran_mode1_reset,
        .set_mp1_state =3D aldebaran_set_mp1_state,
        .mode2_reset =3D aldebaran_mode2_reset,
--
2.25.1



--_000_CH0PR12MB5372BE5474A9F08CD247FB6EF4789CH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12pt;"><=
a name=3D"_msipheader9f8d35bc"></a>
<div><font face=3D"Arial" size=3D"2" color=3D"blue"><span style=3D"font-siz=
e:10pt;">[AMD Official Use Only]<br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Comm=
ent inline . </span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of sa=
shank saye<br>

Sent: Friday, December 17, 2021 1:19 PM<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Saye, Sashank &lt;Sashank.Saye@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough f=
or sbr handling</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">For =
Aldebaran chip passthrough case we need to intimate SMU about special handl=
ing for SBR.On older chips we send LightSBR to SMU, enabling the same for A=
ldebaran. Slight difference, compared
to previous chips, is on Aldebaran, SMU would do a heavy reset on SBR. Henc=
e, the word Heavy instead of Light SBR is used for SMU to differentiate.</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: sashank saye &lt;<a href=3D"mailto:sashank.saye@amd.com">sashank=
.saye@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Chan=
ge-Id: I79420e7352bb670d6f9696df97d7546f131b18fc</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 9 ++++-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp; 4 +++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +++---</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/smu_types.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 6 +++---</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c&nbsp; |&nbsp; 2 +-</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ++++++++++</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 9 f=
iles changed, 28 insertions(+), 16 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x f31caec669e7..0c292e119f7c 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2618,11 +2618,10 @@ static int amdgpu_device_ip_late_init(struct amdgpu_dev=
ice *adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&quot=
;, r);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI + passthrough configuration o=
n arcturus, enable light SBR */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_ARCTUR=
US &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_passthroug=
h(adev) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi=
.num_physical_nodes &gt; 1)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For passthrough configuration on arctu=
rus and aldebaran, enable special handling SBR */</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"red"><span style=3D"font-si=
ze:11pt;">[shaoyunl] This will change the&nbsp; behavior for ARCTURUS, whic=
h only need to set light SBR for XGMI configuration .&nbsp; You still need =
to check XGMI for ARCTURUS, but don't do that check
for ALDEBARAN</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_ARCTU=
RUS || adev-&gt;asic_type =3D=3D CHIP_ALDEBARAN ) &amp;&amp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_passthroug=
h(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; smu_handle_passthrough_sbr(&amp;adev-&gt;smu, true);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_phys=
ical_nodes &gt; 1) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd=
/pm/inc/aldebaran_ppsmc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 35fa0d8e92dd..ab66a4b9e438 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
102,7 +102,9 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine PPSMC_MSG_GfxDriverResetRecovery&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x42</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine PPSMC_MSG_BoardPowerCalibration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x43</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x44</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine PPSMC_MSG_HeavySBR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x45</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x46</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> //P=
PSMC Reset Types</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine PPSMC_RESET_TYPE_WARM_RESET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/i=
nc/amdgpu_smu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 2b9b9a7ba97a..ba7565bc8104 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1257,9 +1257,9 @@ struct pptable_funcs {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fine_grain_gfx_freq_=
parameters)(struct smu_context *smu);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @set_light_sbr:&nbsp; Set light s=
br mode for the SMU.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @smu_handle_passthrough_sbr:&nbsp=
; Send message to SMU about special handling for SBR.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_light_sbr)(struct smu_context *=
smu, bool enable);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smu_handle_passthrough_sbr)(struct =
smu_context *smu, bool </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ena=
ble);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @wait_for_event:&nbsp;=
 Wait for events from SMU.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1415,7 +1415,7 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bo=
ol en);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-int=
 smu_set_light_sbr(struct smu_context *smu, bool enable);</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t event_=
arg);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/in=
c/smu_types.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 18b862a90fbe..ff8a0bcbd290 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/smu_types.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/smu_types.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
229,7 +229,8 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(BoardPowerCali=
bration),&nbsp;&nbsp; \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(RequestGfxclk)=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(ForceGfxVid),&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(UnforceGfxVid),</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(UnforceGfxVid),&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(HeavySBR),</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #un=
def __SMU_DUMMY_MAP</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine __SMU_DUMMY_MAP(type)&nbsp; SMU_MSG_##type</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/in=
c/smu_v11_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 2d422e6a9feb..acb3be292096 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
312,7 +312,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> voi=
d smu_v11_0_interrupt_work(struct smu_context *smu);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-int=
 smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ena=
ble);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 smu_v11_0_restore_user_od_settings(struct smu_context *smu);</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm=
/swsmu/amdgpu_smu.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x af98fa140d83..76f95e8ada4c 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3058,13 +3058,13 @@ static int smu_gfx_state_change_set(void *handle,</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-int=
 smu_set_light_sbr(struct smu_context *smu, bool enable)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex)=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;set_light_sbr)<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;set_light_sbr(smu, enable);</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;smu_handle_pass=
through_sbr)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;smu_handle_passthrough_sbr(smu, enable=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mute=
x);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/dr=
m/amd/pm/swsmu/smu11/arcturus_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 58bc387fb279..505d2fb94fd9 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2472,7 +2472,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =3D =
{</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .deep_sleep_control =3D smu_v1=
1_0_deep_sleep_control,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_parameters =3D arctur=
us_get_fan_parameters,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .interrupt_work =3D smu_v11_0_=
interrupt_work,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_light_sbr =3D smu_v11_0_set_light_sb=
r,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_handle_passthrough_sbr =3D smu_v11_0=
_handle_passthrough_sbr,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D smu_cmn_set=
_mp1_state,&nbsp; };</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu11/smu_v11_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 28b7c0562b99..4e9e2cf39859 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1724,7 +1724,7 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-int=
 smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable)</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ena=
ble)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/aldebaran_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 7433a051e795..0e60d63ba94f 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_=
map[SMU_MSG_MAX_COUNT</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetUclkDpmMode,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetUclkDpmMode,&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxDriverResetRecovery=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PPSMC_MSG_GfxDriverResetRecovery,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(BoardPowerCalibration,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; PPSMC_MSG_BoardPowerCalibration,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(HeavySBR,&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_H=
eavySBR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =3D { @@=
 -1912,6 +1913,14 @@ static int aldebaran_mode2_reset(struct smu_context *s=
mu)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aldebaran_smu_handle_passthrough_sbr(struct smu_context </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+*sm=
u, bool enable) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D&nbsp; smu_cmn_send_smc_msg_with_p=
aram(smu, SMU_MSG_HeavySBR, enable ? </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+1 :=
 0, NULL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)&nbsp; =
{&nbsp; #if 0 @@ -2021,6 +2030,7 @@ static const struct pptable_funcs aldeb=
aran_ppt_funcs =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gpu_metrics =3D aldebaran=
_get_gpu_metrics,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset_is_support =3D al=
debaran_is_mode1_reset_supported,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset_is_support =3D al=
debaran_is_mode2_reset_supported,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_handle_passthrough_sbr =3D aldebaran=
_smu_handle_passthrough_sbr,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D aldebaran_mod=
e1_reset,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D aldebaran_s=
et_mp1_state,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset =3D aldebaran_mod=
e2_reset,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.25=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
</span></font>
</body>
</html>

--_000_CH0PR12MB5372BE5474A9F08CD247FB6EF4789CH0PR12MB5372namp_--
