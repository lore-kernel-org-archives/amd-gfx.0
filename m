Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF4C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33B461176
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33B461176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600D66E503;
	Wed, 14 Apr 2021 09:12:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3567C6E503
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 09:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ9sWYJDKUFAfFpEE2Vu/022jdVinEGh4wTHfUTRY2O3QNYT+SK4vfL7gv6zU3y6Q+KcHOhlM2IS/v3uJDfWnMMhK/1QiJWBXPaUa3vBZawN1a5tEBlWRAUwIGSMqfAC4AnaxIuY9arqktKBU7KR1zMzhv5E6rQiW+2x5yFpc7C17SoeHPprkLM8taMFt+tDFJWXGvOHcQ6M7ktVIqLV4WU64urNXBDuPuuYyQXt6qAWFdn9WdlwIkRk39yAxuiwclgk2k0ASlO3RpmB35SF2TmLdQrChvJt79ueBuVh1tQYj4frmUKpJPbPIb/Zg8pcgBHweCpjNn9vlii92frqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFvNFgfal2JNin2ERHgf8L6lDfRfPGndwPEoIfTp1/0=;
 b=dO1MKDbA4H3gHCoOyTxCC7xmXJtdYkM8Pc28uOMpJ3eaJCNpcLMVs39MH9HHeomX/ftcln8snMOIWvMt/AUsW89j3wQpcoQODyObcA/3lZR+qmrYO/jWJuVGgqhYBZZF732kjphN7AQGMKLFYwJwZY8NuwjshLMgGEmQ3Mcrf6tS8mP+Amvf/+etnRfuEicCNrgFBaHe5LPXMvZ9haSE8fOgjXq00RN/JxgZvFk1RXgIojh/JFBKhKAXFTKUiTcTmULrP5abzqfMwmjLQNz0SRmc3/Lr8WY3uYlaIGmf9hZ9i55C2C+hAkAYAqHomdr4rF7m9IC+VfFpJIPffzagVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFvNFgfal2JNin2ERHgf8L6lDfRfPGndwPEoIfTp1/0=;
 b=UkdiDLCV89FTdzi2FW+WJjWQD77P3ShMbBX+psRUkRdBYy4AYPzjroLLqtFTeWaE2JQq2s1hjlNjxgKh4VbpPhrgA0yVKTZxIiVDC96X0gxeQ4Oa+6IATmvqJF3xr+N36haV97QT52O4QquUloU9vw5SKdcar1N29nN8gZINkAQ=
Received: from DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 09:12:22 +0000
Received: from DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::ed0c:db00:2e8f:565b]) by DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::ed0c:db00:2e8f:565b%7]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 09:12:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Topic: [PATCH] drm/amd/sriov no need to config GECC for sriov
Thread-Index: AQHXMQ0ewefihVe/2kaSShF2HspBXqqzulqQ
Date: Wed, 14 Apr 2021 09:12:21 +0000
Message-ID: <DM4PR12MB5374D7A8D7637D4F6E6C3935FC4E9@DM4PR12MB5374.namprd12.prod.outlook.com>
References: <20210414090355.737034-1-Jack.Zhang1@amd.com>
In-Reply-To: <20210414090355.737034-1-Jack.Zhang1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-14T09:12:15Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f856fae4-e3d0-40d3-a388-c6ded42cf9a1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45d7d97b-0f75-4c5f-7e14-08d8ff25696d
x-ms-traffictypediagnostic: DM4PR12MB5344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB53442CDC8EAEA1C9F3BD67B1FC4E9@DM4PR12MB5344.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o21fMOE3hm4tkEA8FRki/b124xM06h+YVJSF+6ZFGhQ9pG6CDxqGJUu7yQPYIoCvbpkLt7MY1wyapZeGU9kAJn6ZWvaprI3xZRgWltPbOvZVaPL+YdvUVz7wAaaj5OrLG6hKPvBBj+Rv65zu2zOcSQYNlmSen+xG+hNR771oLI1Q8UYM4sHMo2r+cGyjNRalLDU+Ec5jRJOnNC4TYayThxpQlOkf6OYskfVVxLm6Dh7dJA36cKLccXocDAlgCAE6EAwPx1HUtEFwfDD9HyFjJY5YM1H+Nd+SbnHhEPDH1U4gL4h3R+WcnE8I6/GvNZ1Iaro8mv6DyMMoBdZJt8EeJu1+TAeoOsg4DiezvaT02wkvXAZOZ++p6g0alW3zT++oGS+G0NsnibfCm0z0A2Qle8gXo/9wYEBgBMkp05qiStbQ+nFY0kUETCg2f8HXCKiWUCGARbhT3l8cWw+ec8ujNrnqxOeICONWFDSo+gPkAViZzrwkntqBwN53E48UgtSmbdkoPHlssO/bQIsS12lue82lYMYHoBuYosyRS9E0jNGP8Fsq+s8X+ESwKUfv6bzO8Ptv96Iz+vBBQBos/XUMni2nenfzZ6sijieA2KPnhEU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(7696005)(66946007)(122000001)(186003)(8936002)(55016002)(5660300002)(38100700002)(26005)(66446008)(478600001)(8676002)(71200400001)(4326008)(316002)(9686003)(66476007)(52536014)(76116006)(66556008)(86362001)(6636002)(83380400001)(53546011)(6506007)(64756008)(2906002)(110136005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hOhhfayyH2ZpQXfxnm/3HRINgfR532C1vFlqQI4uHLhtAGoFkH4SNrqrqVOM?=
 =?us-ascii?Q?mSiE/angGgAsg0kNc4BfhCOgZZPySfj/Rgi+8xjT+4mxpg89zlsgrOFOXClq?=
 =?us-ascii?Q?AgCKUJYz8eVR/Oa4J/GhaRzKNeBPzl8tmCZYQ+yfbro5QdUOzKR8d89Skz9d?=
 =?us-ascii?Q?QwvvHwnqaegWseUnCmQVrtKdUFP02aJxy4Iv/u5nzgkv04PwD1sLWJXQdor5?=
 =?us-ascii?Q?4h5u9uk4Mz0hzIkTghL1fe3folYkAfUhaeqRTnjBsDxSnLFaEBMhelJaBTxn?=
 =?us-ascii?Q?Uu/fFvxyHz9AKWVhAoezP0enObDethIwAELCC/0j1iokQdSYC01GoBmYM+KU?=
 =?us-ascii?Q?ZtXUv4surfX1/pdJFZUHTy9ZQhTktik0I3aalwwmnWqvCPgz8zCtWYCMzJbr?=
 =?us-ascii?Q?KpIBy5Gl+BIOK/OV4pZV3PYmiey1oCB7jTvtA88qlDZTobDiaHq4uifrtlNW?=
 =?us-ascii?Q?xTrW5a5LgMlHsaDwLLNh8f43+aF8l7EytQW69+UfdXzhYKZlInkoFJbmQiuD?=
 =?us-ascii?Q?pl6NL8u/Wn+IPxYsz18XySJLWCTHQXMmexcpKv85fW2cfk0uvEnb/S/HejoB?=
 =?us-ascii?Q?QcRPtzvGnP7CYtpC0RuOnn18kcs/hIpMcOx580D++l6M4quM6B/czgevQNIk?=
 =?us-ascii?Q?h3x9sKuk3kMMjAgZ6QOpHdFiEcg5XC3kw+lfIS/Q4sWxF7TEtKTVyNNBxe39?=
 =?us-ascii?Q?kwanxWo/4p58cWWDHwFX8pTWy4v/NRmRx+lvfQu8ZKmr6DUG4CqB7WeJFdVz?=
 =?us-ascii?Q?ZgsvnWC7uaMd8X4c/hjM06EHe3a6iLkHK6OYoDr+CedxtNOL6DJ136m6jrkU?=
 =?us-ascii?Q?MrIsX/IgFy7Ld7Hn4/5lyGTs1mIyn1sB9yjSqESXqL8czgeSH14zjCVj4Pom?=
 =?us-ascii?Q?FCMGSSsUUcMRrnnAi+ejhKGs403WL/NF56t3MTm3DyG5KKJJyJOuX6JdWmba?=
 =?us-ascii?Q?Oq8YFpk2bnhlO0dLPV8Ak4SE8otYJykNHEH0WeFWejGcwd4x/6g4gdjodUhI?=
 =?us-ascii?Q?G1baTCkygNwW9KXmj7owMNnrBohtBh75g0dh9BDDzoq9o/zOP+I7zoOAixn0?=
 =?us-ascii?Q?kHnowEKAMYbG/hhYCz5FRF44oTWazk3zye8K6Zvy5af8q6EsRhMakI6ikqpO?=
 =?us-ascii?Q?19rgZDySh/mJytgfo1I1WH1u4aiuMGswTYLFsFgFzjq0pOMQ551+2IphxrXG?=
 =?us-ascii?Q?Y1f3Qi6/vnGoS3mF3IA8EpYx0XR4xzK6p54I2GZUxzoqk8XdzCHhQfiKFQCY?=
 =?us-ascii?Q?pARZdQbSS9XMqsNm6iWlK4a4qlMJHkrXJNUu30QZrODM6vqoEuiD+Cxjp1Wz?=
 =?us-ascii?Q?aeVHjL/qxFyrrvvp6hqBM9US?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d7d97b-0f75-4c5f-7e14-08d8ff25696d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:12:21.8470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1jSAWR9KlN0tnOjJgAasx549WocV81Js33ETEBNjmZR35zBrUkayNAStFFgnbt71zEOu7pcS2YApye8wzodIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Wednesday, April 14, 2021 17:04
To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amd/sriov no need to config GECC for sriov

No need to config GECC feature here for sriov Leave the host drvier to do the configuration job.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 123ab3156f5a..7bdf93716fbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -567,7 +567,7 @@ static int psp_boot_config_set(struct amdgpu_device *adev)
 	struct psp_context *psp = &adev->psp;
 	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
-	if (adev->asic_type != CHIP_SIENNA_CICHLID)
+	if (adev->asic_type != CHIP_SIENNA_CICHLID || amdgpu_sriov_vf(adev))
 		return 0;
 
 	memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
