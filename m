Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5970C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 03:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F7210E3E1;
	Tue, 18 Oct 2022 03:37:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3167D10E3E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 03:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozb/VAsEqxDJdrHDR+vsUmj15ojTJBJI8MuatR5JC/EM7cobKIIa9NVxXws0iBVU5v3Mm9Vbu3CPn3bAmL+vrfngseXsfvZHKdBaqazbvZsSNmt6NF+RNkfH9fYZM5mg02HlYkHtCIrByXgEVCV+R47tpuGlHXT187niBnEcxnEP1E2l61cpo6XnxTO1kYT8jjmUJL87sKTwLplSPZUPjQjOE0ITuF23CV/jfh7gdikwo7l1kMpdrdDnJXBEAK7oE6ECYwulKQFHDchc8Zpg1QBOPnkHIgSF+RUixwIE30/C0wsLG6a9ueilQFgVbeJc3/RHp6gDQFtSpfZLcdLrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4sxrh0Ieu4cLuJEds6Icnf2zG1hVGPnHY/LmJmsWcc=;
 b=Jp64ac9wBx1lF6GYMyDdEHP9r6/ApTpIYv+D90wUkK0dqWj8suOAXBZkte6PJm55OXawTQANh6MwM5sKEyIyAHp2fYFBGSLWqd1Q0ji9zaUAsf1t/HvmVGRXflVd+AXgUI5MQ1bZpJjAKgAEslPejrcCKxNdS9H2UjDBJgBUxndrgy3WIoCUxmjftHAo+8wBl4Sjm9iMWyLqwtWDOYZfp/LQcXCPeX8IF3lsoWEkFqOLaamIBVhbPPMphK+lUDFmiJ9q/0nrZeofzwdY/1FizaKzODD6xeQuu4SYgrrWOkIiCyMM9CuJ8QIUOUV27naCjxBsGKLol/dbu7XRJ26XbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4sxrh0Ieu4cLuJEds6Icnf2zG1hVGPnHY/LmJmsWcc=;
 b=Qs94YXeFmGeUhIrFJLRGnWWyvRfHBma0JX+ArRlJ2ke5N4sVBpsmXoB4ezFiGfpiCwfBOkpBKUXEidcFNsOIBdlzZ0K7ouIYoXegApOWb67pAv7P1F5VDjjzcl6sqh9zTr/hE7c+wtfhG6YKkujfpiXu4I6ScRCAg0Fn9lz13uA=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 03:37:14 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::9cba:9f5a:fcf9:b07f]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::9cba:9f5a:fcf9:b07f%9]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 03:37:14 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini
Thread-Topic: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini
Thread-Index: AQHY33345XjQUUC1j0OJhBNgNHpnDK4TfuCH
Date: Tue, 18 Oct 2022 03:37:14 +0000
Message-ID: <MW3PR12MB4458D16FFF4498C5DAA25C88EF289@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20221014033419.3461246-1-YuBiao.Wang@amd.com>
In-Reply-To: <20221014033419.3461246-1-YuBiao.Wang@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-18T03:37:13.401Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4458:EE_|BY5PR12MB4228:EE_
x-ms-office365-filtering-correlation-id: 6dc8f31d-51c7-4ab2-cb03-08dab0ba0c28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9eexqhfq7Psd3NNmE0i4YlfCBpAI27pRfM1pFl3nfZYdBwkauzLoe6G06l/x7pswlicMNGFcbeLxf3T93VybIe81g3klymU2wY5m5+okPQYvu1rCEQ+zoK9mc/vovEWt8Cl7l+LLdimEG61UQ3afkVsi4Hk7g/qPeBfcC1TC19HCbPZ2d/5Hk3GtN+hpcuqORcjpgfchltyJKpnH7Ud7UA/zJVUmdrsXK6hD1OD2oF43oq2WrfzRf+2TsdB1vhuzyfLvUndy/RhQviqbi4ljKWH6kD6r2qJD7XNSJVbz1ii2WdbUuHikcqKrRPPNdHWtPsK5+V3SiARYIWvwiG3Z701Op6eJ7zaE+YLqpcEANlyp9Tm6favyS2wAPztA79ZLslUYYdvLw3NnxkjlDumBBPxswft3szIe0kavmXSFW+TtJtSgqKMLsHZsZ0Wr0g5w5C8KOGI0kA8YxFZCUVf2fxy7nAfy8aeWRFcdVjNBFaidqxgGUq0XYmoQuasdyQbEHzBUXq8S+RlSbrNQi6MdBRfUKaCsbmG6qyE+m6hnCTqR0ZTrlkb7KPs0nI7OaLlWDmgt3ZH+ulXUNOttPO89QF2Ok/dH17xiYY0pZYIxfFdDphXBeO6EYKUe0fPntV95y9+gp0BhLI6CzyEenum29T7iqt7KieUMOJGdIbPhJ1LU9bXCCXwu2trcOTj96onCitLVTcJk8D0imWeKu2bWAmqTbYKEpYRMLLdwOS38v+qZjBO6p966XgLl8jFEprErWdpb31fLEvaG2PKeH8yDNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(71200400001)(186003)(38070700005)(26005)(83380400001)(86362001)(5660300002)(2906002)(38100700002)(52536014)(8936002)(4326008)(41300700001)(55016003)(122000001)(8676002)(64756008)(478600001)(9686003)(7696005)(6506007)(53546011)(316002)(76116006)(66476007)(66556008)(66946007)(66446008)(91956017)(54906003)(110136005)(33656002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KR4asGrpIsdy2qHR4lBzVE+uTSGhIKBPBWd1LEgXzutyatYk2J9j5Jfo0D9B?=
 =?us-ascii?Q?jjtQGLyrfNkNDkG1DYK3rmchvZnmBP/t6N64dgDA9erggU+4H/dfVwm1xDvF?=
 =?us-ascii?Q?oJmQ3xgz3kUpCgn/TuY3jKzk1uCWT/VijxvfXPhUL4BIsDJIT2iSIyyIqhgE?=
 =?us-ascii?Q?d8Fqu6PucJ8XaqDILM6/wrt1u9sGrxVior5GfHPcgHQ1w3VXacYGUzOMKNit?=
 =?us-ascii?Q?a0V/jR/LpCZeMGmsSk/W4DhQ10d31VRFl2KD8bf+v2cl1LDwh3ODq0vS50br?=
 =?us-ascii?Q?/ROGQ9M2zqhV1/TL6Bzz20NqdFK1IuKPzsi7b+vyniaBzpB8qFyYgwa1ksr5?=
 =?us-ascii?Q?7vnUyKtRXI7pOadyB+xVVgDgIvnERw6bHXcNIVSvs5r+KbQ0DBy6kU6q3646?=
 =?us-ascii?Q?GhxoxDnjA0Rol960p+tNdYEXxLdTX3UJZrq2vI6NVzZKuM/7bKmm7ftQrIrw?=
 =?us-ascii?Q?pSYQIRiBYDrWZ8W6iDKR+paniiL8xlGITnZWpmthrut0LJOVO417me8iJivJ?=
 =?us-ascii?Q?947PuorG7aIyTnvDea2mzIMpXysqmTOkzJrgLP1/WtQI8PY3Av/c5AJ+9tuP?=
 =?us-ascii?Q?lTXZqQhrUg3JtLSEdOF0o3yLMZABBjXtOwUhA8uofIU48I6julY3SK807fAz?=
 =?us-ascii?Q?a30a8f92WmBd4taIkTzBMLxMo5KY6R+PaoXFLQF5nlrsL2VPNOKR6mPvbDZ0?=
 =?us-ascii?Q?iFNsIXKAva1lvSBafp+kPYDiTaIHmmNMWrgv3L/IOeWH/m1JauBdg3Zme2dw?=
 =?us-ascii?Q?P4G3/UeYu5HRvbvhQHKhjgru3JfQBgXJ181EY6K00cZm8meJvqO7EPH2iTKO?=
 =?us-ascii?Q?yIQR7tTQp4Npkvr4YLKtHiADllUyKPYYJCP4tLo1LEgi09xFbh/SWPPscL5Y?=
 =?us-ascii?Q?FjevWCusG5ZKE9V9az0MS6m1QczW0jqDUU2YLSYz2d43/5ley0q/KcVUfRDf?=
 =?us-ascii?Q?tPamj/lT/K7tIEMe00o5TStwpXvbKQ3b3RgSEYu9sHPDWAEoqA4sFQXJvzhJ?=
 =?us-ascii?Q?Q3h3c7bDfBf2pqmSWuZol9azRpJZ0BjdVCqyeCunqTBx03aTPtXhvwBzr0ZE?=
 =?us-ascii?Q?I8jo4dKVdlYu0i7hN+BOW02Sa5bPGAjTz7vcEKrHkQG1J3wcz8lL76EYyPsw?=
 =?us-ascii?Q?/DgsvgqXi5OX37JoWsQYdS8iTj5LqqTQ+rWC6KY76e8j7qjQ4GQcIQUEcvGZ?=
 =?us-ascii?Q?7UkFABjA7WW5mwe1lhC+yNHccl2Emt+cii6pxG0epi01xXvQ7+Ty87I2D8f8?=
 =?us-ascii?Q?ht6I4O6uByxi0B2DCZOB3lvB6X1L+OdIJi7SZlt6BCdH4elrDPpKUzmeI9tN?=
 =?us-ascii?Q?R6vV61SsFKOpTlA54a28jtryj2t5D5+nMCSM2xpQkyxl9Lwm7oApWOL66Vm9?=
 =?us-ascii?Q?4FG9soP2rQvkkh59uQWF9fL5ocmhJvsgbInJN5hDiHqU+DOpm445Qpil3yKg?=
 =?us-ascii?Q?c9hCA+mrgoNyIyB+YIgrXd/y69HhTsX89FrBJ5TFQe0oGccWzRWqUERph0YF?=
 =?us-ascii?Q?tcHHsgNBbQbpswgVmzaztT3lpZEu3zC6VvGhqSVH9fefCg5vdLv9Dli541jm?=
 =?us-ascii?Q?W3aWFOtFb8J5AxhRq98=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB4458D16FFF4498C5DAA25C88EF289MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc8f31d-51c7-4ab2-cb03-08dab0ba0c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 03:37:14.0439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSuJJ6Lr+GdB76KlKvPA6Ko3UWyN+zJcRigKyKsACvpNLicHuUzMbXTODpeYlrc7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MW3PR12MB4458D16FFF4498C5DAA25C88EF289MW3PR12MB4458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


>> +       /* dequeue sched pipe via kiq */
>> +       void                            (*kiq_dequeue_sched)(struct amdg=
pu_device *adev);
>> +

It's unnecessary to expose a new callback function proto to perform dequeui=
ng scheduler queue,
for kiq_fini or mes_hw_fini callback had got the propriate sequence to do t=
his during fini procedure.
In addition, it seems that the issue is caused by that unclear CP_HQD_PQ_WP=
TR/CONTROL registers would trigger scheduler reading from unexpected addres=
s once CP_MES_CNTL is enabled:
a. for dequeue operation uses MMIO rather than kiq, can the dequeue operati=
on move to mes_v11_hw_fini?
b. if something went wrong, it's better move the dequeue operation inside m=
es_v11_0_kiq_hw_fini before disabling mes controller.

Regards,
Jack

________________________________
From: YuBiao Wang <YuBiao.Wang@amd.com>
Sent: Friday, 14 October 2022 11:34
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <A=
lexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <=
Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu=
@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Wang, YuBiao <YuBiao=
.Wang@amd.com>
Subject: [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini

Update: Remove redundant comments as Christian suggests.

[Why]
If mes is not dequeued during fini, mes will be in an uncleaned state
during reload, then mes couldn't receive some commands which leads to
reload failure.

[How]
Perform MES dequeue via MMIO after all the unmap jobs are done by mes
and before kiq fini.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 41 +++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index ad980f4b66e1..ea8efa52503b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -130,6 +130,9 @@ struct amdgpu_mes {
         int                             (*kiq_hw_init)(struct amdgpu_devic=
e *adev);
         int                             (*kiq_hw_fini)(struct amdgpu_devic=
e *adev);

+       /* dequeue sched pipe via kiq */
+       void                            (*kiq_dequeue_sched)(struct amdgpu_=
device *adev);
+
         /* ip specific functions */
         const struct amdgpu_mes_funcs   *funcs;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 257b2e4de600..7c75758f58e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4406,6 +4406,9 @@ static int gfx_v11_0_hw_fini(void *handle)
                 if (amdgpu_gfx_disable_kcq(adev))
                         DRM_ERROR("KCQ disable failed\n");

+               if (adev->mes.ring.sched.ready && adev->mes.kiq_dequeue_sch=
ed)
+                       adev->mes.kiq_dequeue_sched(adev);
+
                 amdgpu_mes_kiq_hw_fini(adev);
         }

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index b48684db2832..eef29646b074 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -44,6 +44,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
 static int mes_v11_0_hw_fini(void *handle);
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev);

 #define MES_EOP_SIZE   2048

@@ -1078,6 +1079,7 @@ static int mes_v11_0_sw_init(void *handle)
         adev->mes.funcs =3D &mes_v11_0_funcs;
         adev->mes.kiq_hw_init =3D &mes_v11_0_kiq_hw_init;
         adev->mes.kiq_hw_fini =3D &mes_v11_0_kiq_hw_fini;
+       adev->mes.kiq_dequeue_sched =3D &mes_v11_0_kiq_dequeue_sched;

         r =3D amdgpu_mes_init(adev);
         if (r)
@@ -1151,6 +1153,42 @@ static int mes_v11_0_sw_fini(void *handle)
         return 0;
 }

+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
+{
+       uint32_t data;
+       int i;
+
+       mutex_lock(&adev->srbm_mutex);
+       soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+
+       /* disable the queue if it's active */
+       if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+               WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+               for (i =3D 0; i < adev->usec_timeout; i++) {
+                       if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+                               break;
+                       udelay(1);
+               }
+       }
+       data =3D RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+       data =3D REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+                               DOORBELL_EN, 0);
+       data =3D REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+                               DOORBELL_HIT, 1);
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, data);
+
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, 0);
+
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO, 0);
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI, 0);
+       WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR, 0);
+
+       soc21_grbm_select(adev, 0, 0, 0, 0);
+       mutex_unlock(&adev->srbm_mutex);
+
+       adev->mes.ring.sched.ready =3D false;
+}
+
 static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
 {
         uint32_t tmp;
@@ -1257,9 +1295,6 @@ static int mes_v11_0_hw_init(void *handle)

 static int mes_v11_0_hw_fini(void *handle)
 {
-       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
-
-       adev->mes.ring.sched.ready =3D false;
         return 0;
 }

--
2.25.1


--_000_MW3PR12MB4458D16FFF4498C5DAA25C88EF289MW3PR12MB4458namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&gt;&gt;&nbsp;<span style=3D"color:rgb(36, 36, 36);font-family:&quot;Segoe =
UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -=
apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-=
serif;font-size:14.6667px;background-color:rgb(255, 255, 255);display:inlin=
e !important" class=3D"ContentPasted0">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
 /* dequeue sched pipe via kiq */</span><br style=3D"color:rgb(36, 36, 36);=
font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,=
 &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Hel=
vetica Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255,=
 255, 255)" class=3D"ContentPasted0">
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color:rgb(36, 36, 36);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important" =
class=3D"ContentPasted0">&gt;&gt;
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*kiq_dequeue_sched=
)(struct amdgpu_device *adev);</span><br style=3D"color:rgb(36, 36, 36);fon=
t-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &q=
uot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvet=
ica Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 25=
5, 255)" class=3D"ContentPasted0">
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color:rgb(36, 36, 36);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important" =
class=3D"ContentPasted0">&gt;&gt;
 +</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color:rgb(36, 36, 36);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important" =
class=3D"ContentPasted0"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color:rgb(36, 36, 36);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important" =
class=3D"ContentPasted0">It's
 unnecessary to expose a new callback function proto to perform dequeuing s=
cheduler queue,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color:rgb(36, 36, 36);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important" =
class=3D"ContentPasted0">for
 kiq_fini or mes_hw_fini callback had got the propriate sequence to do this=
&nbsp;</span><span style=3D"color: rgb(36, 36, 36); font-family: &quot;Sego=
e UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;,=
 -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, san=
s-serif; font-size: 14.6667px;">during
 fini procedure.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px;">In addition, it seems that the issue is caused by that
 unclear&nbsp;<span style=3D"background-color:rgb(255, 255, 255);display:in=
line !important" class=3D"ContentPasted1">CP_HQD_PQ_WPTR/CONTROL registers =
would&nbsp;</span></span>trigger scheduler reading from unexpected address =
once CP_MES_CNTL is enabled:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px;"><span style=3D"background-color:rgb(255, 255, 255);displ=
ay:inline !important" class=3D"ContentPasted1">a.
 for dequeue operation uses MMIO rather than kiq, can the dequeue operation=
 move to mes_v11_hw_fini?</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px;"><span style=3D"background-color:rgb(255, 255, 255);displ=
ay:inline !important" class=3D"ContentPasted1 ContentPasted2">b.
 if something went wrong, it's better move the dequeue operation inside&nbs=
p;mes_v11_0_kiq_hw_fini before disabling mes controller.</span></span></div=
>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px;"><span style=3D"background-color:rgb(255, 255, 255);displ=
ay:inline !important" class=3D"ContentPasted1 ContentPasted2"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px;"><span style=3D"background-color:rgb(255, 255, 255);displ=
ay:inline !important" class=3D"ContentPasted1 ContentPasted2">Regards,</spa=
n></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"color: rgb(36, 36, 36); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px;"><span style=3D"background-color:rgb(255, 255, 255);displ=
ay:inline !important" class=3D"ContentPasted1 ContentPasted2">Jack</span></=
span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> YuBiao Wang &lt;YuBia=
o.Wang@amd.com&gt;<br>
<b>Sent:</b> Friday, 14 October 2022 11:34<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; Tuiko=
v, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &lt;Christian.Koen=
ig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;
 Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd=
.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.=
com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Wang, YuBiao &lt=
;YuBiao.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3] drm/amdgpu: dequeue mes scheduler during fini</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Update: Remove redundant comments as Christian sug=
gests.<br>
<br>
[Why]<br>
If mes is not dequeued during fini, mes will be in an uncleaned state<br>
during reload, then mes couldn't receive some commands which leads to<br>
reload failure.<br>
<br>
[How]<br>
Perform MES dequeue via MMIO after all the unmap jobs are done by mes<br>
and before kiq fini.<br>
<br>
Signed-off-by: YuBiao Wang &lt;YuBiao.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |&nbsp; 3 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp; |&nbsp; 3 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp; | 41 +++++++++++++++++++=
++++--<br>
&nbsp;3 files changed, 44 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index ad980f4b66e1..ea8efa52503b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -130,6 +130,9 @@ struct amdgpu_mes {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*ki=
q_hw_init)(struct amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*ki=
q_hw_fini)(struct amdgpu_device *adev);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dequeue sched pipe via kiq */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*kiq_dequeue_sched)=
(struct amdgpu_device *adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ip specific functions *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_mes_fu=
ncs&nbsp;&nbsp; *funcs;<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 257b2e4de600..7c75758f58e1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -4406,6 +4406,9 @@ static int gfx_v11_0_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_gfx_disable_kcq(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;KCQ disable failed\n&quot;);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;mes.ring.sched.ready &amp;&amp; adev-&gt;mes.kiq_de=
queue_sched)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.kiq=
_dequeue_sched(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_mes_kiq_hw_fini(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index b48684db2832..eef29646b074 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -44,6 +44,7 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_11_0_3_mes1.bin&quot;);<b=
r>
&nbsp;static int mes_v11_0_hw_fini(void *handle);<br>
&nbsp;static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);<br>
&nbsp;static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);<br>
+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;#define MES_EOP_SIZE&nbsp;&nbsp; 2048<br>
&nbsp;<br>
@@ -1078,6 +1079,7 @@ static int mes_v11_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.funcs =3D &am=
p;mes_v11_0_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.kiq_hw_init =
=3D &amp;mes_v11_0_kiq_hw_init;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.kiq_hw_fini =
=3D &amp;mes_v11_0_kiq_hw_fini;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.kiq_dequeue_sched =3D &a=
mp;mes_v11_0_kiq_dequeue_sched;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_mes_init(adev=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
@@ -1151,6 +1153,42 @@ static int mes_v11_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 3, AMDGPU_MES=
_SCHED_PIPE, 0, 0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable the queue if it's active *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(GC, 0, regCP_HQD_ACT=
IVE) &amp; 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;usec_timeout; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(RREG32_SOC=
15(GC, 0, regCP_HQD_ACTIVE) &amp; 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, regCP_HQ=
D_PQ_DOORBELL_CONTROL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, CP_HQD_P=
Q_DOORBELL_CONTROL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOORBELL_EN, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, CP_HQD_P=
Q_DOORBELL_CONTROL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOORBELL_HIT, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOOR=
BELL_CONTROL, data);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOOR=
BELL_CONTROL, 0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR=
_LO, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR=
_HI, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR=
, 0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 0, 0, 0, 0);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex=
);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring.sched.ready =3D fal=
se;<br>
+}<br>
+<br>
&nbsp;static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
@@ -1257,9 +1295,6 @@ static int mes_v11_0_hw_init(void *handle)<br>
&nbsp;<br>
&nbsp;static int mes_v11_0_hw_fini(void *handle)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)handle;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring.sched.ready =3D fal=
se;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4458D16FFF4498C5DAA25C88EF289MW3PR12MB4458namp_--
