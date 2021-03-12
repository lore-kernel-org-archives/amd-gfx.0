Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84182C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 13:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3977664F9E
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 13:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3977664F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AA96F634;
	Fri, 12 Mar 2021 13:54:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF006F634
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 13:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSzDKW1g7k7idGO34VSIys9zcLkIq+PErCvxelnAoC1Jkwd1m8sfWfXdFS6PLmBM7mKqR9FSeBGwFyGo+IvWsLgGrDodHfcs/gfZRJF6wvO3yxfcWU7Ac1nlaXzSATbqJYlEZkxw1wmV9qJUDN+IEvP00xsL2zPVy5VFxX92t+2SJIHn30n1BNoc2N6NIJfgS0zKiF2gItKXWaXSMBmHu7lQnCC2089yEcsMVudgHXrC5dGYXGleCS2wBNnd5y/4owEQZwfyOnrvJIyICOvD0yjdqKPWc2nfB8TBIkmtLLmbqNKk3g0f7LV9dYxcKbCdYs1Ij9djXkHipBG4hGgAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GC5HfXGrG6fcahhHB8SEu5IsqEBAw3PCkd8PqbtMFhI=;
 b=Lnp3FS3JIKxUE2WV0EudEa8OBRwMOd94vskCh8iQjE+6s9Q6wFQKywGLsPyh13fr6myCwYeZUEI/bpIfpDsIs2uxcT15DKsQF37yqqLrd2V7wK+nlVJMYyIjlFQDjjStEjpVvhB9XyheZTjTmRvUL2VxclTjobz87R6OdUaq4xa5W1uEHRsfJ++T7MktF+vuHcz5g/OygAdIyCu0YZW2IKVfE0awm2TByygRhZyqkHmDtzyBTU+9S0u2U6BdHsAbClRch5JXh9C3B1FSF5u9z8w1PYiBKD662SDxK5tOzlNkCjVh6EncTqbMMPJ/cQ3HZjA5IKEVa0cLCyI7aUxdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GC5HfXGrG6fcahhHB8SEu5IsqEBAw3PCkd8PqbtMFhI=;
 b=vFiy2A8LmG7aegJ5r4I1lfLzxqSoC5GUiM/5pnnP0pAT66W/eQkiJmSuW9IL7fOgwW8YcYZr9h7LAVg9nsd0YHW77HwHKLI48ujWRIXbXhKcxGvnFzvjDBhMp7uXSHxCPOwLGoX5xclD6xNMzbDuCwd4tTSdr+f8UiS04P84oQA=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 13:54:36 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 13:54:36 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Topic: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Index: AQHXFpo6OffAU9/QCU2PzCAhGlJLMqp/tYhggACqyICAAAB8AA==
Date: Fri, 12 Mar 2021 13:54:36 +0000
Message-ID: <MN2PR12MB45495A8F65EBB79F58CCA142976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210311171548.10671-1-shaoyun.liu@amd.com>,
 <MN2PR12MB45495AB3BB248A637F218F38976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
 <DM6PR12MB3835F2F751F9A0F52009CC5EF46F9@DM6PR12MB3835.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3835F2F751F9A0F52009CC5EF46F9@DM6PR12MB3835.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T13:54:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ff272384-ee4d-41d9-8a3c-8f064fc901a2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.202.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec91e555-fb4e-4c51-aa7d-08d8e55e5fba
x-ms-traffictypediagnostic: MN2PR12MB4253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42534170EE954549DDC8C51F976F9@MN2PR12MB4253.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L5Mu4FfWglzJdA8xJjB/ujHSTgqb4JdPuXJaw0+cs8G6Wzo2f1VNENBWx0+ZQHAKCpS4Z8P4dbF+CV7qhd6I6OCSyhyHSSrXczTyH/ueTYKc2LDs3BsDNyQmqkgbdxZ4eUeRKByPrar//9Rxa7UT9FU0qp+JfOnvFQiqqDVLiJ1ka9/LQ6flR5nhTWYGCLeTgnDT8yWeAMNkpR9X6CEid5MgdJ0zJzyS0IPl54tF5T+s5qD/8T7UWMPrFm8eWGN995u9QlcSqceHqcNv2TrElbFati0uuARknWfts3t9PHzBP+o5HliMqncj1cYTHYHTy/UQou3cdVU9kbnO1JyFVdo6WYGESAKwc21uVK1mI0+br3N4w+r82etjn2Vv+cCVnuvacBzCv2I4QOdY03Huo9rdDjuGlnNcda/FpsEdPGH1OZwgPO/t8sKx15onlrEy7maCKJH26sDBT3YIiOd/jXn6Phe4J9Z42ZC+TtCTb344BuKp8UDgIIGftys3Y+FJMC9cEWSEwLN9GTvpYjpoBR2tMlCC6CaweZol0kpyovTDWnWaE5hUvvLBIUWPLmYb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(966005)(316002)(53546011)(110136005)(55016002)(71200400001)(9686003)(7696005)(86362001)(76116006)(52536014)(2906002)(64756008)(186003)(6506007)(55236004)(33656002)(5660300002)(66476007)(166002)(45080400002)(66446008)(8676002)(478600001)(26005)(66946007)(8936002)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5QMDPOvHf0UoCSE1GR/dUBW9OenM4ECuzfeRdlnitaB6b9lruqGHM4U6+OWl?=
 =?us-ascii?Q?Pu205rpzQGAGXgyYtWifY41eG/thDC6L6QMugv/F7a8QGEPWlnBNYZFOHgiw?=
 =?us-ascii?Q?7JXnjrDG5ZJFuodYq9bFhbLKx2Ne1erUJyaYrj+FAv0RD6igm0IJ3VTX6iew?=
 =?us-ascii?Q?3OH/RY8oNMEepX9ARfYRhYXnOjnA6H7gzUZU/eHlDfOkiCANIddXSU9+1qMo?=
 =?us-ascii?Q?HG5+fwxM0BNni2CWs4JQYCs+QagE+8BvEe0k6OmqEGKPHquC2ulgXsq8TvAy?=
 =?us-ascii?Q?u+4UKcOoTdfGDIvcJ+ZmbTCNXr4QzLDNedr6JNyW7K3guHMlNKFLMHtb9b1s?=
 =?us-ascii?Q?KesiduAw/D0b8eciX3RRJ3JvghmIVeiuG0umcQVRtQ3v7wzW/fyZN46er7zi?=
 =?us-ascii?Q?CqYXQJeS6KITbwmadcIJdbfcDUaQpPcR04piTJtkZJRd+bT/bWvbeT307WE/?=
 =?us-ascii?Q?pUlAvNH/W3SjoqhYkhOPF5j6niDGAuEZ/eMgGbYKYLHSiWjYh775lafSSLYt?=
 =?us-ascii?Q?yMHLaYhi42Jwl3xCAhVq98y5N8jFbQzrm2vlAvnWhd4ofoRZFW0ltPF+UoYy?=
 =?us-ascii?Q?Gu1Q11YjJWl54rfxgiiWN+Kdc8VL6v8CVjo441Z5100KKOsEB4BcEYjk3SY5?=
 =?us-ascii?Q?bY2DhU8KtCQNQ8NI3Qj9WFBChHlYxrSoamLEJnbBt23OyA6z/7lOtmSsHl6j?=
 =?us-ascii?Q?F9kCaeOvLSxI+8IhoF2jQT3QtWR/V1ufauQeOMDAGEU22RDlSrwzFeRG/rNH?=
 =?us-ascii?Q?ytkIowSVqtrCwpr3gzke+SZwf71lT8/5X+7YAp+qp2hrjAh7QMAN4+pb4yZQ?=
 =?us-ascii?Q?+RbZKD2mDWsBPCvRV2U9NaE1WkRuEhOK6sxOCf/mU3JNXGQuiHjs15R7xThQ?=
 =?us-ascii?Q?NJv6ECqPiiHB+jx5UHIsKb3jDNgb6hNNfDJgsPnfxnCYC8RopUS0fWuCO35u?=
 =?us-ascii?Q?pMrc/kChh6MBlY6+LsJnPo/NOc6731OOomrmb2RXurdocX2ajfR/fAuDB8+R?=
 =?us-ascii?Q?9ona9ah764H2n+YjOTxsggjG8wcpTMNbvOvbtkk5qcyZVav4M3ojzhotqgEg?=
 =?us-ascii?Q?HabI97ZzqzhLkgBmZVaWVpG/OeCiRbx88UjJveJ++tQqsLRPe9ojuLXqGlht?=
 =?us-ascii?Q?W7XqeM4T6/dhpx3L+BuZmNX3VJnM2dtQSQyM5KyO6L4yE7U0J9GVCw4WJrKK?=
 =?us-ascii?Q?S3PCTX9HyLTJBMnXwWiTXdN6Ym4iukxrrXBb3ppBQAG0AnD0M3BLrdSVDKna?=
 =?us-ascii?Q?O+8luJmghzlZ8lu7Qkbg/nfUu7sMCLLmsUo+orIYYesMicOoowmKJm/nuSaB?=
 =?us-ascii?Q?9dCgtFBM3mH9dOtMnwvYbj5C?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec91e555-fb4e-4c51-aa7d-08d8e55e5fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 13:54:36.8083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5TzlAnwYAdwrm+SKm+LfjYOGk1kQ7VZS5RvlwxijX9JvCXK2BnefS7FY230l9HI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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
Content-Type: multipart/mixed; boundary="===============2055705773=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2055705773==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45495A8F65EBB79F58CCA142976F9MN2PR12MB4549namp_"

--_000_MN2PR12MB45495A8F65EBB79F58CCA142976F9MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

We want to keep ppt_funcs minimal. Adding everything to ppt_funcs and keepi=
ng as NULL is not the right way. Please keep the code to arcturus.

Thanks,
Lijo

From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Friday, March 12, 2021 7:21 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration

Thanks for the comments. This light sbr solution could be applied to other =
asic as well. In swsmu code, It will check whether the function pointer set=
_light_sbr is valid before real call the function. So for other asics if th=
e smu apply the same change, just add the ppt function pointer and we will =
have this support without further code change.

Thanks
Shaoyun.liu

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: March 11, 2021 10:42 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration

[AMD Public Use]

We don't need this as a generic ppt_func. Reset functionalities are changin=
g over programs and this could be valid only for Arcturus. Please move it t=
o Arcturus swsmu late init.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of shaoyunl
Sent: Thursday, March 11, 2021 10:46 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configura=
tion

This is to fix the commit dda9bbb26c7 where it only enable the light SMU on=
 normal device init. This feature actually need to be enabled after ASIC be=
en reset as well.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com<mailto:shaoyun.liu@amd.com>>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index cada3e77c7d5..fb775a9c0db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
         if (r)
                 DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);

+       /* For XGMI + passthrough configuration , enable light SBR */
+       if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes >=
 1)
+               smu_set_light_sbr(&adev->smu, true);

         if (adev->gmc.xgmi.num_physical_nodes > 1) {
                 mutex_lock(&mgpu_info.mutex);
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         if (amdgpu_device_cache_pci_state(adev->pdev))
                 pci_restore_state(pdev);

-       /* Enable lightSBR on SMU in passthrough + xgmi configuration */
-       if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes >=
 1)
-               smu_set_light_sbr(&adev->smu, true);
-
         if (adev->gmc.xgmi.pending_reset)
                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_wor=
k,
                                    msecs_to_jiffies(AMDGPU_RESUME_MS));
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D7nd=
htOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;reserved=3D0

--_000_MN2PR12MB45495A8F65EBB79F58CCA142976F9MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We want to keep ppt_funcs minimal. Adding everything=
 to ppt_funcs and keeping as NULL is not the right way. Please keep the cod=
e to arcturus.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt=
; <br>
<b>Sent:</b> Friday, March 12, 2021 7:21 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Thanks for the comments. This light sbr solution cou=
ld be applied to other asic as well. In swsmu code, It will check whether t=
he function pointer set_light_sbr is valid before real call the function. S=
o for other asics if the smu apply
 the same change, just add the ppt function pointer and we will have this s=
upport without further code change.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Shaoyun.liu<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.co=
m">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> March 11, 2021 10:42 PM<br>
<b>To:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
<br>
We don't need this as a generic ppt_func. Reset functionalities are changin=
g over programs and this could be valid only for Arcturus. Please move it t=
o Arcturus swsmu late init.
<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of shaoyunl<br>
Sent: Thursday, March 11, 2021 10:46 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd=
.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configura=
tion<br>
<br>
This is to fix the commit dda9bbb26c7 where it only enable the light SMU on=
 normal device init. This feature actually need to be enabled after ASIC be=
en reset as well.<br>
<br>
Signed-off-by: shaoyunl &lt;<a href=3D"mailto:shaoyun.liu@amd.com">shaoyun.=
liu@amd.com</a>&gt;<br>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----<br>
&nbsp;1 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index cada3e77c7d5..fb775a9c0db1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&=
quot;, r);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI + passthrough configurati=
on , enable light SBR */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_passthrough(adev) &amp;&am=
p; adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_=
physical_nodes &gt; 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);<br>
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_cache_pc=
i_state(adev-&gt;pdev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci_restore_state(pdev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable lightSBR on SMU in passthro=
ugh + xgmi configuration */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_passthrough(adev) &amp;&am=
p; adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.pend=
ing_reset)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_delayed_work(system_wq, &amp;mgpu_info.delayed_=
reset_work,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffi=
es(AMDGPU_RESUME_MS));<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Clijo.lazar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;amp;sdata=3D7ndhtOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;amp;re=
served=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04=
%7C01%7Clijo.lazar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3D7ndhtOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;amp;r=
eserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB45495A8F65EBB79F58CCA142976F9MN2PR12MB4549namp_--

--===============2055705773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2055705773==--
