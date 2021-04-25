Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC80C433B4
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FA26140F
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 07:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FA26140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1466E4F4;
	Sun, 25 Apr 2021 07:31:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53DA06E4F4
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 07:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2PB1OWZ5/8Z6z32A8B2kh3KLi276a2YniDG7PTxUP6e95ovA2JW8l9CuleMuyen2+h+1FKs1NHqPD5TJSGBR1VULsEMzbGZq494/HjQ8SYyHOz59khp6RFmruT0eijw2RZ8tfNx5V1UgR7v7v750wUDBQaihJuCWjpqhvQ8S04Ihktt/sPOGkQt17FiC4HZSJ2DtRBXPo+gMpFGuNoJ6vocHFXkJKeasCaiJE8cKdd3atyvJuDmkDjdH55eEMBmqastLonjOnoSEGbvnYRM4y9S2lFPsQ65J7Vag88gbB2yUgC34dHIXXga4/P//+mMjaZypBmP97/XQiZWexUiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta6ojk4PKz3rfU+iLfcRB4VR23Pc7yKPg5YFAuJN//4=;
 b=iADbDe0zOywxQiITzbIMIoO2cN2S0QAzFvHwpxzTgu2C14NCrntu9HNgmSo8ZaNa8RLp1QoF82L88h2bsCBFxyevzRTOdOZ2pgzwhaXvnW1OA0S+kt7V0LmXUY0nu2NCjmyDykuVF8ioDO6L9mNf5iXJrgfnU3CSOyeLVrHGYV5yxopzWBOrc5va/897YCkIkMfWBEi57X7ZMRNej6nnWsqJLAyXIRox4Fx82VQ5ZNa1QThGdmnkAwLMYhVUYxOLNYIKAiN93bo8pAv6jn6tKz+Y68T2as7q3HdK5gFCczKMJ4EG+kICZmQNuFnrpa688yOk74YRrjnWtT5pF8bcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta6ojk4PKz3rfU+iLfcRB4VR23Pc7yKPg5YFAuJN//4=;
 b=F+Bo22RPgISkC5Dq4pbBoo94nQTCfdLsncJIUhftQuDusJFmV8B5cQfukwTO/sf9lGeSKiceM62DopQ09h31lbfA7i0JX8jPFuM75S8mH23Vovf0NRdq5aRXQW7+/RALPVEMcaNP4QLZU2gqD4O9S/0ETTUBfu+tHXZmZr+U3sg=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com (10.172.77.147) by
 CY4PR12MB1368.namprd12.prod.outlook.com (10.168.169.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Sun, 25 Apr 2021 07:30:58 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f%3]) with mapi id 15.20.4065.025; Sun, 25 Apr 2021
 07:30:58 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: provide socket/die id info in RAS message
Thread-Topic: [PATCH 2/2] drm/amdgpu: provide socket/die id info in RAS message
Thread-Index: AQHXOaISt6hDxRnFNUCZsNl+m+TGtKrE1pIA
Date: Sun, 25 Apr 2021 07:30:58 +0000
Message-ID: <CY4PR1201MB0072452ACF87ACE30D9E990DFB439@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <1619334622-17940-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619334622-17940-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-25T07:30:53Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=10582772-84c5-4d3b-be83-9cc28bd062f7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d3b1430-397f-4e9f-ba83-08d907bc11cf
x-ms-traffictypediagnostic: CY4PR12MB1368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB136815C0C58391217C3E6A90FB439@CY4PR12MB1368.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:116;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6VxdLZvy2zrm/OASH/VLXtBLFU2pLvj7KIUhuqXqT2XjrHcFer2TxN/0M08UKvctlRl+tUHB8qiRNSVLrFP0GSVfDY7z3djgXFfdQvj0HNSaC3QmuHMNOSh/C68FqQx6LXANfxN7JSw395QfDNAM6zQPX5isTlkR27YgzNkj3RJxhMrDFHXAbqVpOy0+1Ds26jAjVqnBCCGfhj7iFqa1WcKpsUjnZOagpNiOcwMxLsAkk8yZG8A61UJTcy5t0D8hdQ1202BIe52qBfeqF8wFCecl9Psgq16CF7rNIzNgt0EnF+Ujrv00xCEXqT5QAdUPyC+6TTCVmyesJSHk+qQ43SpsA7dVtopD0t3/PTMq14MJ7B+herbGpcfiFfOKFdVsXm94KUyYlMa8E75WY1HmQOtHFgL731T0kagNbBC1Q76/T1DbVUx0R7cyb++iFBZd4vjax2sCjhhyuxbxIy7ipSjLQm1rC8277wliB9Q+jNugRCJdyF90ZDGDxc1UOJhByzF18zm/1QtZkLUE0Fc9I641KXDwDso+JPQQQpP591/8YvQF+iRm+9wKFHyJrglYeHQKvOzTH0p3znOyZDEUJ3W2aWCTTckd9l27LX3b9g4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(8676002)(8936002)(6506007)(6636002)(316002)(33656002)(9686003)(55016002)(66476007)(71200400001)(66446008)(52536014)(7696005)(478600001)(76116006)(66556008)(66946007)(53546011)(122000001)(15650500001)(64756008)(5660300002)(186003)(110136005)(38100700002)(4326008)(83380400001)(86362001)(2906002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JVqzpdfllpvE2QnlYblTcv/U/aK6Fxo7MIKNqJX2kNXIKAcA/TFggqCFlHfe?=
 =?us-ascii?Q?+vkqV+oGe279LkgOWcQF9KoR8xQVmVqYiD9lDqHvTwBBkONwNq0jWFD9lNyU?=
 =?us-ascii?Q?tUXJ5akkwsRBUeCUWONRQeLg6V7U/sAd6tKAKb5TeMvEs/7AmcWqgjy7jOWa?=
 =?us-ascii?Q?onI80DEP6MHaE//7P7TJn66I32fJ4bN1a1RTJgt41jhXD0NpqpGl0bouIkKg?=
 =?us-ascii?Q?xu6Vp+9nbo8eKMldyD7AqzFxN7Ffb1eIX3KpEMeqMZoUYz5Cj0BpFIjGGbaD?=
 =?us-ascii?Q?gKqeCusD7Ik2FhgRZUvAuG3FEnM0YLYPytmDIGOT2vSviSOuKDdoVQAzJ2rU?=
 =?us-ascii?Q?zHZUemkZXd8fVIa9J0yM3EHhl+2nnbOSTEYKK3yzkotjfaqJLxtH6YTaSuzq?=
 =?us-ascii?Q?w4Slq2bl+9rpozahkfd4BzIm95ab3uyR57SHMutWlYiN0i/CWkoewzGlzNjO?=
 =?us-ascii?Q?WP4753wwIaqLBMl2YWxUhuWLPaAkm2bcArnTRvDP+hT3Zrm3fPKfovL/pIgt?=
 =?us-ascii?Q?2FN39+wvzRAdwfwsWt3aGado2BJK2cAtvbKo33CkW8s3FKMBldRvAMzOzpiQ?=
 =?us-ascii?Q?MDlwuUndVPj7LqyYptzAYrg2iYbJBybs8pQyGlSH2LoKvHr5xEAvHknIYXGN?=
 =?us-ascii?Q?UAKYPCag706L0kajUak19+6u1fSkbN+k8FO/o86CU2LfuUGvIb9gbCucgC2R?=
 =?us-ascii?Q?jwjvSkHvLz+qpAr6vNnWYoPw2B8LagarXGrQM2Gdkf9lJcJWG3e/tyIDoge5?=
 =?us-ascii?Q?yCAePJr102G9fdZwZcTv3ABc5j71o9yTGHSmqb9VCXyxA1v0xgTenvhAojXg?=
 =?us-ascii?Q?Ra1CdiDU8ffDLVRFrD50REjiD//TUHDjdtgbrMHljeGNQmkqrfbHO8j67sfW?=
 =?us-ascii?Q?LIjLGrZ/82t5nHB3EjJqJoJN+y9v3fbirb82KGNJgVIT4+nB0T05AzMCS7/f?=
 =?us-ascii?Q?nxnVQ2yB6G9AnRodPG47KayNpnLQqufxaGTqXwcdnBPAVUixXUiasAAUB23Y?=
 =?us-ascii?Q?sgmRm9O/9VGxLixqVKnIPWslw7rdytjaPZyfDbJCb9lXIvkXDLDCg/+tfzJj?=
 =?us-ascii?Q?vDvn8TQ86GZtk1sSHxiA+kIZrqqjQbB4Q15e+rCNOYMTHJ881y81d/omRQli?=
 =?us-ascii?Q?r/TzdjYkkeUJbrWnXdDEAHQpuNCRYO7Mx98u+4WWXO+gbqk6HAwtNjXftPzF?=
 =?us-ascii?Q?KNnhoNCrPHaq9L086BIPfkTpFIJ2qhFhlNb3n29vQeSqajXeWCClEb9TlRpc?=
 =?us-ascii?Q?P64ydD7ECbd5nW+OEfAeCKkT9T0wjnXckJppSflYNSO9J659DZVD1//+WtTR?=
 =?us-ascii?Q?v01t1SCLIB32t+aTuJAkohcU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3b1430-397f-4e9f-ba83-08d907bc11cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 07:30:58.2838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hF3gVsFAritaxklUl6RV60CGVpnIRA0X/9T6YpkCgO54kR+mz6sJDVBzP+9aQ70PiVgZTKIWrtrcflQDMB7WdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1368
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements<John.Clements@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Sunday, April 25, 2021 3:10 PM
To: amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: provide socket/die id info in RAS message

Add socket/die information in RAS messages for platforms that support query those information

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f62873f..ae9fb20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -901,17 +901,42 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	info->ce_count = obj->err_data.ce_count;
 
 	if (err_data.ce_count) {
-		dev_info(adev->dev, "%ld correctable hardware errors "
+		if (adev->smuio.funcs &&
+		    adev->smuio.funcs->get_socket_id &&
+		    adev->smuio.funcs->get_die_id) {
+			dev_info(adev->dev, "socket: %d, die: %d "
+					"%ld correctable hardware errors "
 					"detected in %s block, no user "
 					"action is needed.\n",
+					adev->smuio.funcs->get_socket_id(adev),
+					adev->smuio.funcs->get_die_id(adev),
 					obj->err_data.ce_count,
 					ras_block_str(info->head.block));
+		} else {
+			dev_info(adev->dev, "%ld correctable hardware errors "
+					"detected in %s block, no user "
+					"action is needed.\n",
+					obj->err_data.ce_count,
+					ras_block_str(info->head.block));
+		}
 	}
 	if (err_data.ue_count) {
-		dev_info(adev->dev, "%ld uncorrectable hardware errors "
+		if (adev->smuio.funcs &&
+		    adev->smuio.funcs->get_socket_id &&
+		    adev->smuio.funcs->get_die_id) {
+			dev_info(adev->dev, "socket: %d, die: %d "
+					"%ld uncorrectable hardware errors "
 					"detected in %s block\n",
+					adev->smuio.funcs->get_socket_id(adev),
+					adev->smuio.funcs->get_die_id(adev),
 					obj->err_data.ue_count,
 					ras_block_str(info->head.block));
+		} else {
+			dev_info(adev->dev, "%ld uncorrectable hardware errors "
+					"detected in %s block\n",
+					obj->err_data.ue_count,
+					ras_block_str(info->head.block));
+		}
 	}
 
 	return 0;
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
