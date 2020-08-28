Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE11C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 00:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456592080C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 00:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P56SVL9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456592080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130AC89A94;
	Fri, 28 Aug 2020 00:01:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938F789A94
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 00:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEBusx2dv4inkRCktq0GHjRy+JUAD+bMdPd3UEo3+D2UY3ah3VL1ZEs52JslNhdZ+OIHr3XO59FHpmVHd1R4wojnC6MsmaqL0cm6sCatrDApFzru741uerApUndWruu3mlwDum2hGaLp+CHGpFI/IAVBUtXvaQMvO3UR8tVoEE1YyzpTx3svSRUsuFaheKAhRL7xYTInpdoSn63P1gI3bjeyQa1tCjvSVCuwEzKtiOuM16y2AMpNBGXaFvIhjRWivXXYJgD/7eYJD+/LHlCRGyrd/6gqVKcU3cx8x9NwLmPkha20PDqX84K9R/jPwVbc5S+ChRX0t7Zy3Rx9v5JUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEF5RdZ4FpxPkLfhtRDdrYNullt3/CaC1es55FSGuPI=;
 b=g3TM2APIkCVbQbRtm/97y8Pxy3dFz2opwbfv+Qpyhm5tfy8zkn4WYgBvTVz9z8LzYwT58JWqlwuQjoRfOnJucZBHBYkYNEEqOxFFVB9eOUyC7yMqd9Wer8Vazb9iBiZOkRt6go52GzXVNhcvkJrxvYxUf//Lt3P63dcvDYY5wcvvYJ9brtLT4V0WgmY/lf0L5EYLSVm6EJioDqRsETTX9TIaNw3aR7Dh6jd7EiCdFQuHdGfKwA1KkAbKrgl8+ey6GCm2CJvkt+OpkgeQmkoG2WKEyhLqdVv1JAouelWOjJn2gwSd4FEZ3AqhPQ28vF7yrMOAeEzNfEBdd4w4vwX8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEF5RdZ4FpxPkLfhtRDdrYNullt3/CaC1es55FSGuPI=;
 b=P56SVL9dCteQewAlq4zQgMdweh9+uK2AjNviEa3yGNpc9Xfz+bMGvcNVBDqXVjeOYKWlb9v968nkQOH07rjEVO02g9CPDHcOI0ZBKHNlDYEuL9QWVfxYoUdqM0uTB7ZsMpjj7PKM/pfDFeS58HDQELyc/j0YHYSrLOu43ieVsrI=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Fri, 28 Aug 2020 00:00:59 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 00:00:59 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure.
Thread-Topic: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure.
Thread-Index: AQHWe7e3ljfiLe0O7EKTXky+COrJPqlKgVsAgAGLLYCAAJiZTw==
Date: Fri, 28 Aug 2020 00:00:59 +0000
Message-ID: <DM6PR12MB434022205C4915275751D413EA520@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-6-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_NtAaNd3_XYrs4K8uLFF49Xv-46801Cy3Y0fNuLG_YPoA@mail.gmail.com>,
 <0c2ada8e-5dde-0165-c8b3-cf6d6d3fba46@amd.com>
In-Reply-To: <0c2ada8e-5dde-0165-c8b3-cf6d6d3fba46@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [199.7.157.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4305201-0410-4192-0489-08d84ae57204
x-ms-traffictypediagnostic: DM6PR12MB4010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB40101EA12A433A45A1A4568CEA520@DM6PR12MB4010.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2dt6EeQgcVF2IXWmaEw9IZNTpPg99lkNdJ6mtjMYwBjWGltVL9rvRnjhUfNBxi8ATdG68VhgmcAg6IgTTNo0pib66eXjOhILhdsGpHcXQURFUd80joEIpRdy287qdPZEGko6Q/3LpWyLCyxpCQ9ZyPM5EdXfOOjucHum3dUKyr7TXNAZLryaRbw9zCrKlTST5fcvKkTN0xPkWN3LmS3jy1lINK6G0Wto7TDKt/4tAOYLEt7V3M38ttE1hw9fiUK7Do1eLfHKwJwTbDZu+RlOdlz6e/S16vUxRQfCWaWWmfJHLRk1GuFrC48wQ8wBflMxTb9/tprNP1uTUiw1Cz6sxL7baCiwnAB7Q4byO5+i6k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(5660300002)(6916009)(86362001)(71200400001)(166002)(83380400001)(55016002)(52536014)(33656002)(8936002)(9686003)(478600001)(4326008)(6506007)(53546011)(7696005)(54906003)(91956017)(316002)(2906002)(66556008)(64756008)(66476007)(45080400002)(66946007)(66446008)(186003)(8676002)(76116006)(26005)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: elKrgGczQhrvhZ8mVz36ePD+rgAOv0sYJhXkuIopmqM2F1R+EW4TINNitWvXTHcQUWVWPpezbiGqxCwA9/Jt78dtjEnSbKJ+mVBhjzfHfu3kSovahGkHGxDP8Gz2EnqN9FTG5900titmnknAirpVWrE1PgOs6Y8Fdjk+OpKHTZEQ9uvSa9CUco0rOoq5Bp5Pzj6ePbfEFEnKRKeV8Z3jvHKa7LL0TrVE6HSMN4ZX2JDo5FnWnNw22hkQNfLGYmVTXPhSjO2dZlMDZgzPioWc2XgzZz/tmbNtRtADeyxfhChS+pMQsN8x8/5U6tgEEsiZy/yYXt+2/552kAPMLDhb3CfA+WkG/gEQbubYdylze5mehrzxNe1PDjiNP15fXmBC0QjB+pSBleZqFj52GoJrK+ywrwyk8hn7HkMxLk82MVYpCFlHAg5mCjFm2md6HmG8WxxH1CEfuCT1iyXTdiESOhdwSHx6MQgvyJl1qtOivn9xQecss5MXH6XUvQ1jGZWTe3jKGzyBarxD4d4wuM78Y+ZQ6Uj3+luEwcTGFueeCXDVaWF26/WHVSaH1BPsz9JDMhDPgX9c77VkvHCaBFJHR0Mo/XwzM3HUTusIXbvjABsM4ZOkV3mFKKBmd3F97B7DBWYP7iry/b66ZqZJ0ZD3Xw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4305201-0410-4192-0489-08d84ae57204
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 00:00:59.2443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3BLz1WoL2z6f08jz9DX1eNbEm8H3xGBtSVvRDT1k+sN9KVeT/KiHL5i60NQginRsmGP+rXk/YABsFaBA1jKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4010
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0126752455=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0126752455==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB434022205C4915275751D413EA520DM6PR12MB4340namp_"

--_000_DM6PR12MB434022205C4915275751D413EA520DM6PR12MB4340namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping

Andrey
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Andrey G=
rodzovsky <Andrey.Grodzovsky@amd.com>
Sent: 27 August 2020 10:54
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Das, Nirmoy <Nirmoy.Das=
@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure=
.


On 8/26/20 11:20 AM, Alex Deucher wrote:
> On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> DPC recovery after prev. DPC recovery or after prev. MODE1 reset fails
>> unles you save the cashe the saved PCI confspace to load it after
>> each new reset.
>> Also use same cached state for other use case of restoring PCI confspace
>> such as GPU mode1 or VGA switheroo.
>>
> We don't want to keep the saved state around in the pci core
> otherwise, the pci core will assume we are managing the saved state
> for suspend and resume.  I think we want logic like this:
>
> At driver load time:
> pci_save_state(pdev);
> adev->pci_state =3D pci_store_saved_state(pdev);
> pci_restore_state(adev->pdev);
>
> then in the case of dpc, do:
> pci_load_saved_state(pdev, adev->pci_state);
>
> For all the other cases, just leave the code as is.


Actually, as we already discussed - caching the PCI confspace only once on =
boot
and not doing it again after each subsequent
controlled or spontaneous reset runs the risk of loading back outdated conf=
space
settings. I am not sure if and when but, is it indeed
possible we make changes to PCI confspace registers during runtime and so t=
he
cached state from boot might be outdated
to load back ?

Andrey


>
> Alex
>
>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 ++++++++++++++++++++++=
+++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
>>   5 files changed, 66 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu.h
>> index 3489622..42ee208 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -992,7 +992,9 @@ struct amdgpu_device {
>>          atomic_t                        throttling_logging_enabled;
>>          struct ratelimit_state          throttling_logging_rs;
>>          uint32_t                        ras_features;
>> +
> Unrelated whitespace changes.
>
>>          bool                            in_dpc;
>> +       struct pci_saved_state          *pci_state;
>>   };
>>
>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *dde=
v)
>> @@ -1272,6 +1274,10 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(struct p=
ci_dev *pdev);
>>   pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
>>   void amdgpu_pci_resume(struct pci_dev *pdev);
>>
>> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
>> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
>> +
>> +
>>
>>   #include "amdgpu_object.h"
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
>> index d9e3994..2c088df 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1283,7 +1283,7 @@ static void amdgpu_switcheroo_set_state(struct pci=
_dev *pdev,
>>                  dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
>>
>>                  pci_set_power_state(dev->pdev, PCI_D0);
>> -               pci_restore_state(dev->pdev);
>> +               amdgpu_device_load_pci_state(dev->pdev);
>>                  r =3D pci_enable_device(dev->pdev);
>>                  if (r)
>>                          DRM_WARN("pci_enable_device failed (%d)\n", r);
>> @@ -1296,7 +1296,7 @@ static void amdgpu_switcheroo_set_state(struct pci=
_dev *pdev,
>>                  drm_kms_helper_poll_disable(dev);
>>                  dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
>>                  amdgpu_device_suspend(dev, true);
>> -               pci_save_state(dev->pdev);
>> +               amdgpu_device_cache_pci_state(dev->pdev);
>>                  /* Shut down the device */
>>                  pci_disable_device(dev->pdev);
>>                  pci_set_power_state(dev->pdev, PCI_D3cold);
>> @@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>          if (r)
>>                  dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>>
>> -       if (pci_save_state(pdev))
>> -               DRM_ERROR("Failed to save PCI state!!\n");
>> +       /* Have stored pci confspace at hand for restore in sudden PCI e=
rror */
>> +       if (!amdgpu_device_cache_pci_state(adev->pdev))
>> +               DRM_WARN("Failed to cache PCI state!");
>>
>>          return 0;
>>
>> @@ -3430,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev=
)
>>          flush_delayed_work(&adev->delayed_init_work);
>>          adev->shutdown =3D true;
>>
>> +       kfree(adev->pci_state);
>> +
>>          /* make sure IB test finished before entering exclusive mode
>>           * to avoid preemption on IB test
>>           * */
>> @@ -4855,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_=
dev *pdev)
>>          /* wait for asic to come out of reset */
>>          msleep(500);
>>
>> -       pci_restore_state(pdev);
>> +       amdgpu_device_load_pci_state(pdev);
>>
>>          /* confirm  ASIC came out of reset */
>>          for (i =3D 0; i < adev->usec_timeout; i++) {
>> @@ -4934,8 +4937,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci=
_dev *pdev)
>>
>>   out:
>>
>> -       if (!r)
>> +       if (!r) {
>> +               amdgpu_device_cache_pci_state(adev->pdev);
>>                  DRM_INFO("PCIe error recovery succeeded\n");
>> +       }
>>          else {
>>                  DRM_ERROR("PCIe error recovery failed, err:%d", r);
>>                  amdgpu_device_unlock_adev(adev);
>> @@ -4974,3 +4979,46 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>>
>>          amdgpu_device_unlock_adev(adev);
>>   }
>> +
>> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
>> +{
>> +       struct drm_device *dev =3D pci_get_drvdata(pdev);
>> +       struct amdgpu_device *adev =3D drm_to_adev(dev);
>> +       int r;
>> +
>> +       r =3D pci_save_state(pdev);
>> +       if (!r) {
>> +               kfree(adev->pci_state);
>> +
>> +               adev->pci_state =3D pci_store_saved_state(pdev);
>> +
>> +               if (!adev->pci_state) {
>> +                       DRM_ERROR("Failed to store PCI saved state");
>> +                       return false;
>> +               }
>> +       } else {
>> +               DRM_WARN("Failed to save PCI state, err:%d\n", r);
>> +               return false;
>> +       }
>> +
>> +       return true;
>> +}
>> +
>> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
>> +{
>> +       struct drm_device *dev =3D pci_get_drvdata(pdev);
>> +       struct amdgpu_device *adev =3D drm_to_adev(dev);
>> +       int r;
>> +
>> +       if (!adev->pci_state)
>> +               return false;
>> +
>> +       r =3D pci_load_saved_state(pdev, adev->pci_state);
>> +
>> +       if (!r) {
>> +               pci_restore_state(pdev);
>> +       } else {
>> +               DRM_WARN("Failed to load PCI state, err:%d\n", r);
>> +               return false;
>> +       }
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_drv.c
>> index 4bbcc70..7a6482a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -1320,7 +1320,7 @@ static int amdgpu_pmops_runtime_suspend(struct dev=
ice *dev)
>>                  if (amdgpu_is_atpx_hybrid()) {
>>                          pci_ignore_hotplug(pdev);
>>                  } else {
>> -                       pci_save_state(pdev);
>> +                       amdgpu_device_cache_pci_state(pdev);
>>                          pci_disable_device(pdev);
>>                          pci_ignore_hotplug(pdev);
>>                          pci_set_power_state(pdev, PCI_D3cold);
>> @@ -1353,7 +1353,7 @@ static int amdgpu_pmops_runtime_resume(struct devi=
ce *dev)
>>                          pci_set_master(pdev);
>>                  } else {
>>                          pci_set_power_state(pdev, PCI_D0);
>> -                       pci_restore_state(pdev);
>> +                       amdgpu_device_load_pci_state(pdev);
>>                          ret =3D pci_enable_device(pdev);
>>                          if (ret)
>>                                  return ret;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgp=
u/nv.c
>> index 4d14023..0ec6603 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device =
*adev)
>>          /* disable BM */
>>          pci_clear_master(adev->pdev);
>>
>> -       pci_save_state(adev->pdev);
>> +       amdgpu_device_cache_pci_state(adev->pdev);
>>
>>          if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
>>                  dev_info(adev->dev, "GPU smu mode1 reset\n");
>> @@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device =
*adev)
>>
>>          if (ret)
>>                  dev_err(adev->dev, "GPU mode1 reset failed\n");
>> -       pci_restore_state(adev->pdev);
>> +       amdgpu_device_load_pci_state(adev->pdev);
>>
>>          /* wait for asic to come out of reset */
>>          for (i =3D 0; i < adev->usec_timeout; i++) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/am=
dgpu/soc15.c
>> index 2f93c47..ddd55e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct amdgpu_de=
vice *adev)
>>          /* disable BM */
>>          pci_clear_master(adev->pdev);
>>
>> -       pci_save_state(adev->pdev);
>> +       amdgpu_device_cache_pci_state(adev->pdev);
>>
>>          ret =3D psp_gpu_reset(adev);
>>          if (ret)
>>                  dev_err(adev->dev, "GPU mode1 reset failed\n");
>>
>> -       pci_restore_state(adev->pdev);
>> +       amdgpu_device_load_pci_state(adev->pdev);
>>
>>          /* wait for asic to come out of reset */
>>          for (i =3D 0; i < adev->usec_timeout; i++) {
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Candre=
y.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;sdata=3DHTTP5xt%2BFTc%2F=
%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Candrey.g=
rodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637341368926287137&amp;sdata=3DHTTP5xt%2BFTc%2F%2B=
lcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;reserved=3D0

--_000_DM6PR12MB434022205C4915275751D413EA520DM6PR12MB4340namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>Ping</div>
<div><br>
</div>
<div>Andrey</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Andrey Grodzovsky &lt;Andrey.=
Grodzovsky@amd.com&gt;<br>
<b>Sent:</b> 27 August 2020 10:54<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Das, Nirmo=
y &lt;Nirmoy.Das@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.or=
g&gt;<br>
<b>Subject:</b> Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries =
failure.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 8/26/20 11:20 AM, Alex Deucher wrote:<br>
&gt; On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky<br>
&gt; &lt;andrey.grodzovsky@amd.com&gt; wrote:<br>
&gt;&gt; DPC recovery after prev. DPC recovery or after prev. MODE1 reset f=
ails<br>
&gt;&gt; unles you save the cashe the saved PCI confspace to load it after<=
br>
&gt;&gt; each new reset.<br>
&gt;&gt; Also use same cached state for other use case of restoring PCI con=
fspace<br>
&gt;&gt; such as GPU mode1 or VGA switheroo.<br>
&gt;&gt;<br>
&gt; We don't want to keep the saved state around in the pci core<br>
&gt; otherwise, the pci core will assume we are managing the saved state<br=
>
&gt; for suspend and resume.&nbsp; I think we want logic like this:<br>
&gt;<br>
&gt; At driver load time:<br>
&gt; pci_save_state(pdev);<br>
&gt; adev-&gt;pci_state =3D pci_store_saved_state(pdev);<br>
&gt; pci_restore_state(adev-&gt;pdev);<br>
&gt;<br>
&gt; then in the case of dpc, do:<br>
&gt; pci_load_saved_state(pdev, adev-&gt;pci_state);<br>
&gt;<br>
&gt; For all the other cases, just leave the code as is.<br>
<br>
<br>
Actually, as we already discussed - caching the PCI confspace only once on =
boot <br>
and not doing it again after each subsequent<br>
controlled or spontaneous reset runs the risk of loading back outdated conf=
space <br>
settings. I am not sure if and when but, is it indeed<br>
possible we make changes to PCI confspace registers during runtime and so t=
he <br>
cached state from boot might be outdated<br>
to load back ?<br>
<br>
Andrey<br>
<br>
<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;<br>
&gt;&gt; Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt;=
<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +++<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 ++++++=
+++++++++++++++++++++---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nb=
sp; |&nbsp; 4 +-<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +-<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +-<br>
&gt;&gt;&nbsp;&nbsp; 5 files changed, 66 insertions(+), 12 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu.h<br>
&gt;&gt; index 3489622..42ee208 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; @@ -992,7 +992,9 @@ struct amdgpu_device {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttling_logg=
ing_enabled;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ratel=
imit_state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttling=
_logging_rs;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_features;<b=
r>
&gt;&gt; +<br>
&gt; Unrelated whitespace changes.<br>
&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; in_dpc;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_saved_state&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pci_state;<br>
&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; static inline struct amdgpu_device *drm_to_adev(struct=
 drm_device *ddev)<br>
&gt;&gt; @@ -1272,6 +1274,10 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(st=
ruct pci_dev *pdev);<br>
&gt;&gt;&nbsp;&nbsp; pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev =
*pdev);<br>
&gt;&gt;&nbsp;&nbsp; void amdgpu_pci_resume(struct pci_dev *pdev);<br>
&gt;&gt;<br>
&gt;&gt; +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);<br>
&gt;&gt; +bool amdgpu_device_load_pci_state(struct pci_dev *pdev);<br>
&gt;&gt; +<br>
&gt;&gt; +<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; #include &quot;amdgpu_object.h&quot;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; index d9e3994..2c088df 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; @@ -1283,7 +1283,7 @@ static void amdgpu_switcheroo_set_state(stru=
ct pci_dev *pdev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;switch_power_state =3D DRM_SWIT=
CH_POWER_CHANGING;<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_set_power_state(dev-&gt;pdev, PCI_D=
0);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pci_restore_state(dev-&gt;pdev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_device_load_pci_state(dev-&gt;pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_enable_device(dev-&gt;pdev);<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; DRM_WARN(&quot;pci_enable_device failed (%d)\n&quot;, r);<br>
&gt;&gt; @@ -1296,7 +1296,7 @@ static void amdgpu_switcheroo_set_state(stru=
ct pci_dev *pdev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_kms_helper_poll_disable(dev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;switch_power_state =3D DRM_SWIT=
CH_POWER_CHANGING;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_suspend(dev, true);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pci_save_state(dev-&gt;pdev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_device_cache_pci_state(dev-&gt;pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Shut down the device */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_disable_device(dev-&gt;pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_set_power_state(dev-&gt;pdev, PCI_D=
3cold);<br>
&gt;&gt; @@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device =
*adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;amdgpu_pmu_=
init failed\n&quot;);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_save_state(pdev))<br=
>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to save PCI state!!\n&quot;);<br=
>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Have stored pci confspace=
 at hand for restore in sudden PCI error */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_cache_pci=
_state(adev-&gt;pdev))<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;Failed to cache PCI state!&quot;);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br=
>
&gt;&gt;<br>
&gt;&gt; @@ -3430,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device=
 *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_delaye=
d_work(&amp;adev-&gt;delayed_init_work);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;shu=
tdown =3D true;<br>
&gt;&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state);<b=
r>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* make sure=
 IB test finished before entering exclusive mode<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to a=
void preemption on IB test<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * */<b=
r>
&gt;&gt; @@ -4855,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struc=
t pci_dev *pdev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for =
asic to come out of reset */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(500);=
<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_restore_state(pdev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_pci_state=
(pdev);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* confirm&n=
bsp; ASIC came out of reset */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0=
; i &lt; adev-&gt;usec_timeout; i++) {<br>
&gt;&gt; @@ -4934,8 +4937,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(stru=
ct pci_dev *pdev)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; out:<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_device_cache_pci_state(adev-&gt;pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;PCIe error recovery succ=
eeded\n&quot;);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PCIe error recovery fai=
led, err:%d&quot;, r);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_unlock_adev(adev);<br>
&gt;&gt; @@ -4974,3 +4979,46 @@ void amdgpu_pci_resume(struct pci_dev *pdev=
)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devic=
e_unlock_adev(adev);<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt; +<br>
&gt;&gt; +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)<br>
&gt;&gt; +{<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D p=
ci_get_drvdata(pdev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D drm_to_adev(dev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_save_state(pdev);<=
br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state);<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;pci_state =3D pci_store_saved_state(pdev);<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pci_state) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;Failed to store PCI saved state&quot;);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
false;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;Failed to save PCI state, err:%d\n&quot;=
, r);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)<br>
&gt;&gt; +{<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D p=
ci_get_drvdata(pdev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D drm_to_adev(dev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pci_state)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_load_saved_state(p=
dev, adev-&gt;pci_state);<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pci_restore_state(pdev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;Failed to load PCI state, err:%d\n&quot;=
, r);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +}<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; index 4bbcc70..7a6482a 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt; @@ -1320,7 +1320,7 @@ static int amdgpu_pmops_runtime_suspend(stru=
ct device *dev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_is_atpx_hybrid()) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; pci_ignore_hotplug(pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_sav=
e_state(pdev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
device_cache_pci_state(pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; pci_disable_device(pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; pci_ignore_hotplug(pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; pci_set_power_state(pdev, PCI_D3cold);<br>
&gt;&gt; @@ -1353,7 +1353,7 @@ static int amdgpu_pmops_runtime_resume(struc=
t device *dev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; pci_set_master(pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; pci_set_power_state(pdev, PCI_D0);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_res=
tore_state(pdev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
device_load_pci_state(pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ret =3D pci_enable_device(pdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (ret)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd=
/amdgpu/nv.c<br>
&gt;&gt; index 4d14023..0ec6603 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt;&gt; @@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct amdgpu_d=
evice *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable B=
M */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_clear_ma=
ster(adev-&gt;pdev);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_save_state(adev-&gt;pdev=
);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_cache_pci_stat=
e(adev-&gt;pdev);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_d=
pm_is_mode1_reset_supported(adev)) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GPU smu mo=
de1 reset\n&quot;);<br>
&gt;&gt; @@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct amdgpu_d=
evice *adev)<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;GPU mode1 r=
eset failed\n&quot;);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_restore_state(adev-&gt;p=
dev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_pci_state=
(adev-&gt;pdev);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for =
asic to come out of reset */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0=
; i &lt; adev-&gt;usec_timeout; i++) {<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/=
amd/amdgpu/soc15.c<br>
&gt;&gt; index 2f93c47..ddd55e3 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt;&gt; @@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct amd=
gpu_device *adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable B=
M */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_clear_ma=
ster(adev-&gt;pdev);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_save_state(adev-&gt;pdev=
);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_cache_pci_stat=
e(adev-&gt;pdev);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_=
gpu_reset(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;GPU mode1 r=
eset failed\n&quot;);<br>
&gt;&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_restore_state(adev-&gt;p=
dev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_pci_state=
(adev-&gt;pdev);<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for =
asic to come out of reset */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0=
; i &lt; adev-&gt;usec_timeout; i++) {<br>
&gt;&gt; --<br>
&gt;&gt; 2.7.4<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;d=
ata=3D02%7C01%7Candrey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a992=
36e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;amp=
;sdata=3DHTTP5xt%2BFTc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;amp;res=
erved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Candr=
ey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;amp;sdata=3DHTTP5xt%2BF=
Tc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Candrey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;amp;sdata=3D=
HTTP5xt%2BFTc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;amp;reserved=3D0=
">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Can=
drey.grodzovsky%40amd.com%7Cf7e5e09330074d176b5b08d84a99236e%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637341368926287137&amp;amp;sdata=3DHTTP5xt%2=
BFTc%2F%2BlcI37wkRQ0BqTHOXOQVpSlR%2FDEnFlM%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB434022205C4915275751D413EA520DM6PR12MB4340namp_--

--===============0126752455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0126752455==--
