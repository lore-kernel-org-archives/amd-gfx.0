Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D28FC43217
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 01:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A2810E640;
	Thu, 10 Nov 2022 01:13:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099F310E640
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 01:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm5wA+pfHdm2GrlPCai1CDYsDzFGun5WxpX0pJnUmMMqCJXuL832eIz6jjw/+6UGZxQN9PTUF4s6k6zwjDJW+q1iHCE1Tef0EvHG3pW9ReX/Iv0xEp81cSVM6J7T0FNJ20KwyKAQNh0laJq3E/9CYBYx3Eprr65jmUaGFRXQiMHTzmuiDWuGKl+x5CvIe/jvOxb8RDfLAIs61vDj5uehQhMoMXdHpqFsLp8SytsjLUkqFbR48+JJgsYQqe2pxl53p9TcD26Fug4MZv/0r00s7LbmvIYC2Q5/jP3JRpoWlfcf4jLF/IinFFc2OqrTooz3fBHZm230HXLjEsAkBe4yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KcwZBNkHZwqglAgqQ8Eg0zYAWvlap+KM8blAW7X+3k=;
 b=oOiVwKfURIqtojhs0aA/AdzbkqKFQgUDIP4iotmzA4LriyU0ti7K6CTIav63rec9o/wNw0w+VQT9vjyGNGjlddMmCAtS+XBwOCbcmBgIqH1HD1OMm9l4SyvyosZnB1k5t3d0zX9NTFaQW1XRz2FquCNid7sTUhBmxTSwB13lwat3UkS3fCBnJFdUgC3er9ERGtOJW7wUric3Fsb7b6pp9IieogQWy4cuAyO0gQuh1Y9dbgb+CB9/IXQUzByawNm0D7H9dsicxnkDDrzPEtJ/Vohs0JMBcyUGJ/MK2sLJQ5KqTUxbplOkw7UEDvWE8uHAH5dG0RdZHI9jAKnIJZ1+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KcwZBNkHZwqglAgqQ8Eg0zYAWvlap+KM8blAW7X+3k=;
 b=0YUW74j2OTGNKwWyLc4TkTWPVZkDd2nCU4aB77Qj8T2vizTNZPtIS1Ic2LtEfD5w1QGMB5PUlaz8r5h7nF/Fl6Yhhpq86i8T7YtzbIDw8NnlbEuuNkVbCOqurlg3E2/mDg88DVEP6EAkiGmzlpEj4dS8paOP+xJ1GuYTsLYKIyU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 01:13:05 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::b9c7:c610:de5a:d73]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::b9c7:c610:de5a:d73%7]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 01:13:05 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wan, Gavin" <Gavin.Wan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Ignore stop rlc on SRIOV environment.
Thread-Topic: [PATCH] drm/amdgpu: Ignore stop rlc on SRIOV environment.
Thread-Index: AQHY9GiP56JxitemZ0yiU74x6qJ9J643WhUw
Date: Thu, 10 Nov 2022 01:13:05 +0000
Message-ID: <PH7PR12MB5997886F3BB4EB48FF0A0BAD82019@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20221109182422.21924-1-Gavin.Wan@amd.com>
In-Reply-To: <20221109182422.21924-1-Gavin.Wan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a25c9cc3-f057-4a41-bf6d-00ae8b4939c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-10T01:12:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW4PR12MB6874:EE_
x-ms-office365-filtering-correlation-id: 3eb9b66e-3908-4d06-f04c-08dac2b8b884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67FofDB35KDQXp1aN4/4fug+HRMJGu4ny1gsKJ5E5L+AaG9A72lL6K0Rb8DUw6u07RpkzWUwRSr6Pkm1A7uYsqJfl3WLt1OmWPdadXH63XSbiy0CAJPE9i2gkL0bTffdkxpazKioq63t23F1Yz/D9xm8bWywES1lhq9KTQQKpjJlWaO2VpeZ5MXmX6YoyVVEJvotjuMzoX/9Bs2t5vvOkuC58F53J5/ZdXleMGvX+XdY+JyVZS2301M8VRZm4aWx74fAggwJF43LclpXUpJPowTGRpRwSjIetB7ThLsHpeXUvExRnYRYzhLS4PMgEsxAIL7nLdDUFOFVvUGrsl81tUQXmsc5a6JheFQmKMVFns9RPgIgNU3aR+/UjNNvj4h2KfdqEiXFGiLUjlrPtOWNCEJTRQvL6s2cnM4LGxEHBHRm891sjMIXyAvqBv89eOLfbAKX15KAuN6/vcPhUV+s/eQzI1kupJEiafKToGtar4YsOf8Owbg0PSrouCeWCkUBp3zK0ENmDNUOsYtRvQfIy9UlVtkMPHsuiKnosMDCFXXiPfyMcadX7avsl0WZe6J+vls5fs/pHnAPc0G51Q7qQUhOU80DW7OZ9phq/4aUCsni14ODdJ+JdjFTrLMSTWqGS6cR0bbW5ygCyDSRg9QqTgNyJwts6R9iCYcp0+h7TyrVIZeUevRP9Srnh+5CQ4BVVj1ToEvX6nVGUTJmO+T4552rTbAGD6Lks+3CIGCE8yBWn781EBMVecbU6TnSK3FpCiaxVY8g/mLlDqtVuj8Xsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(64756008)(110136005)(5660300002)(66946007)(66446008)(8676002)(86362001)(55016003)(66476007)(8936002)(52536014)(41300700001)(4326008)(33656002)(316002)(76116006)(66556008)(83380400001)(6506007)(71200400001)(186003)(26005)(53546011)(9686003)(122000001)(7696005)(2906002)(478600001)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uTNeTCl8FI/CfMlid0ssIkH2UQkNuM9dta09xMXvwIfJFPXzaHu/1FveQK6x?=
 =?us-ascii?Q?DAQbu2jE49kpLebG2z/hLF4bHSA5FfexewyebT8UGE5mOkU7av8rRpkeLhv4?=
 =?us-ascii?Q?SLUXN4zfQxJ5wr+VkyOeHpA7h+5rK2O9Tv5AUQlo6b9QMvvX9VVUiS8Zq9T6?=
 =?us-ascii?Q?W7DFAIq21Xxchbhkbu7GNrSm6yJSsa6XaB8cIDrRtfGq2JpuD7H9AVJ77fJx?=
 =?us-ascii?Q?buT3l0LIm2bfXrHtpMgeOGyv8Cmcidh/lQY9taCvpR5KK+YiezqTQbNkE4NN?=
 =?us-ascii?Q?kpUemQfmdlqqk+kDP/2oq3gGYBj7dr4861T/dS3oxBBxXhUc7VA+XBWTRjIP?=
 =?us-ascii?Q?gb/7V1Jf1n19/siKoxuWSfPofbvM44rcISwXPfPMZkgk2dXXF8lLvycFLMQY?=
 =?us-ascii?Q?YiGFJR3Zlcn+FTCXSeeiDUq1fp08uqB5AcNvYHG9Q+UPmFwgQnISN8VNfIGm?=
 =?us-ascii?Q?k5Q7oaD4UYhtWTmkNGeswrXSDaz7OBvwhb8QJ0+xdW2pbAZcF7JA0J/bi/4P?=
 =?us-ascii?Q?8CNxcTzMuAkwuH7CpvrSDX1RPYN1bEysAMfYgR8X91r83TOisSIi8r8HG6wk?=
 =?us-ascii?Q?JHqe0dYgfvITjcqnLSirCuGnaD4B2gthD4O1rZzmjzPlpFbzhYEerSBJtFQ3?=
 =?us-ascii?Q?9K2WCW6n0D4dUhfpzX6rsGJpshcBJtV5rW+En4WOayiyZnzev/znnbeLQPwf?=
 =?us-ascii?Q?KAROzFi2xz6SPbzQAND8uGvzdHhlTMxsZFOVXSsNQgWgj85WwbInyVQEZntw?=
 =?us-ascii?Q?fSynJcIlNCPeBH2XurdJI0/yXmEt2jFwpKpISSPmims0MYrqSdR7vpErmWHI?=
 =?us-ascii?Q?nw4siNibqDXdP4+BUHQAZbuEpf4PNTvmO4YGHVHrZkJineY355QufDZFIVMt?=
 =?us-ascii?Q?LFzqfMvl5t1fbL2MJnSNF0A3r+N21vIgHHH2BpKoKjUqVdj+DpsHcEifXNsX?=
 =?us-ascii?Q?44YEkEThayh7zarfAnOTbe+l3fCIhv8cbI6ee4Mly80bocm37OjDXkiQtTXy?=
 =?us-ascii?Q?TbWfe6xPbDKrAYNh6xH4ull1Bg2O6GkPYABz4eX1gQQGI0FU9Ss8Z0E+42n0?=
 =?us-ascii?Q?HpQwYZ+ZjuHLrayefUrPfn7RGSbeogOlrIgsG4uVqFRbnP7y6kPIydrRdslD?=
 =?us-ascii?Q?lyaCZKiJ2oonzPoc/7tk/ywHX2o4us0N+X29ChfdTdrmAMh1hebUN0WY91Fs?=
 =?us-ascii?Q?M4CbaElZQEKug2JaUljMKZrHnoY3G2vsf0E9coe+30SfPklZ8UDfUxs0aDYq?=
 =?us-ascii?Q?esZ1FYDlw6VWNoL+hPprX1hhGO0mo09hcbK1AVUx6V26Lkku4qpSO9Wb6Q0f?=
 =?us-ascii?Q?dIJA+ZrALO7MeelaMOEBQ3Y4z2j0YsdyKYCuMqNdEQynKict1iGM3ZyCOc7P?=
 =?us-ascii?Q?hwAsZ7UjoMPqzRW0KWG7aFJqh0XdSJAuOVrzpDdU0INavOofYfMLioJoqv7i?=
 =?us-ascii?Q?5FOmdh4SP7/mrY9gzRBuMQXFsLpjjkUs3OwG1YVnXVmiS+iDDT+b2Q0Xq5wP?=
 =?us-ascii?Q?dVWy1Ji1Oy8bbQbtVm10ucC9vatjrU/q9RAtGTaajR82sP97rNMXWJ26BOd4?=
 =?us-ascii?Q?wHdQVYT511rS5jUVtqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb9b66e-3908-4d06-f04c-08dac2b8b884
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 01:13:05.1525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aglbnQQFPV2IBL4+UloNKb9i9k5vse5MllRV+RczjWhcfPysrnRtNfopfIlm8/6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
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
Cc: "Wan, Gavin" <Gavin.Wan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gavin Wa=
n
Sent: Thursday, November 10, 2022 2:24 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: [PATCH] drm/amdgpu: Ignore stop rlc on SRIOV environment.

For SRIOV, the guest driver should not do stop rlc. The host handles progra=
ming RLC.

On SRIOV, the stop rlc will be hang (RLC related registers are blocked by p=
olicy) when the RLCG interface is not enabled.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: Iac31332e2c958aae9506759de1d3a311b5c84942
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 4fe75dd2b329..0e9529b95d35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1517,7 +1517,7 @@ static int smu_disable_dpms(struct smu_context *smu)
        }

        if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 4, 2) &&
-           adev->gfx.rlc.funcs->stop)
+           !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
                adev->gfx.rlc.funcs->stop(adev);

        return ret;
--
2.34.1

