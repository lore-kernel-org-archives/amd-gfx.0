Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED95C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 01:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DAB2310A
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 01:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DAB2310A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCF3895C4;
	Wed, 13 Jan 2021 01:45:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B06DA895C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 01:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEAi7vlH6OCedgTFZqciT9GOot8rqyd/bPzYMkLyrsYuAJ7O0V9rh+5G/cOgqHpvjF7SgKeL9RzEuW5l+al5cArCPC9WFKvrNy+4SWOzSzTsjCy4aeIsbbiWBsMrCNUKo6XIc6NRwG30Ir5Ehj6XeZauBi696kHEfjZNb82fXHcNGGsqL91w+Zo/bG/w3Sh+flDLI/7ZewUoipLEvHir6oqFGJeB/BD+TSZoTIFSm3LsLU+BskqpPP2z/0oXTlH7y7xU+du9cH4x75pUUKxI8GcVRwLsDPfFp4cdmCVvOCNSwKnY/EdIEWf0LY37aZK83C2DG+PkdQk+M8HJZqH81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUZcHmxvejj+5AuqkLBChfbRj4zyqXmr+5s6TjoSCtE=;
 b=UsXpkEQLKq0RSf8CahbqmCBvqaGrfQo07h+7RVqfZaIGdREIJ1PK5hzsz0utFk6clvQFji65Wsp14X/DUmfAHcLlMwdHUbyrWbBrOJ58JiZZqT65SohSZizPBh9ASQ3p9bJcj7GZzq9YazvSFbxRVfzZ9IyWc+6SFWpPRGCEwKG8fAHCBpa7FBHjBJekKvHUQu6JSRdQP8dWUn+W6o/MfEpp0Z4x4V/5T7vpshjHq6BKLyiDCpFJkL3Rk+nENY+P/VD/hBNpnA2UmbAMlWAA5RDOZjyHBJXE9O3t+ihJX/pXaB0H4TSscdnZPVbtbqKj+8SIAbjUs24l/PVseegN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUZcHmxvejj+5AuqkLBChfbRj4zyqXmr+5s6TjoSCtE=;
 b=e+Du1d251d+bkT6sOLf/hJHDDaqZhEEnspQ9m78ymoOVRkg8FEO+jCmdRn3TmlYmOFUbWaoclEuawNB3n5Wre7ilvidsb6WDXlv+ItZUUUeapC+dQCoyVbbbO6kVzWzqeCOoanB4rcjsEgaLZRqyikiLlDCZ4Tyq48IYmXlPuKI=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BYAPR12MB3351.namprd12.prod.outlook.com (2603:10b6:a03:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 13 Jan
 2021 01:45:32 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::ed48:1313:acd4:8d49]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::ed48:1313:acd4:8d49%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 01:45:32 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix the return value of pm message
Thread-Topic: [PATCH] drm/amd/pm: fix the return value of pm message
Thread-Index: AQHW6M1CLthg394RbU2ls3bDsLp5yKokyMEA
Date: Wed, 13 Jan 2021 01:45:31 +0000
Message-ID: <BYAPR12MB364043FB791CA966A139ECEC8EA90@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210112102508.82417-1-ray.huang@amd.com>
In-Reply-To: <20210112102508.82417-1-ray.huang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-13T01:45:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f4f377d0-29f4-49b1-ac98-0000928061c6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-13T01:45:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 19c65617-7ab0-4151-a58f-000084826b76
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb60ae1e-571d-40f5-5722-08d8b764ea16
x-ms-traffictypediagnostic: BYAPR12MB3351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3351CA12C0A1B22922627E578EA90@BYAPR12MB3351.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fpXCEaQkncg/WURYQSWLmzn6wmDOmKrV7mPzKps86q7Kuv9O2yGpRAnkCOv7fmK2rkKmhZM59gjK3pMnxYJQY6jDR9mJjiixjxKHZfyuX4Rz0GZN20ZrDqrFhyD6kzjejux+9ckeuxlQfrZkMlT2qXJ1r975Mp+57KTFWEnmNt2dLWA7sKJnMdYwCgqBo6G9ici3gOSMzd9uPwP4dY2dZ5aflp3DTwfJSwBCAVrdNnxKZ2loesg178FdOyTFPueff2NB1lywGLxFMu9ToYE3MKFqfEZ6yPJPYn+eYpfGckt74YXr95Q3ij1tDsjVPM09/UE28hbUfp0Go9SmT5ne/CYez0T609i3MQAJGG32VbMoIDW9mt31yefN9zsc7+L+dZwaYEsqPwO7s4gpMFpLxW62zhunWKqShRqD7I1Vm7U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(53546011)(76116006)(6506007)(52536014)(55016002)(4326008)(966005)(26005)(66946007)(316002)(7696005)(66476007)(110136005)(33656002)(8676002)(186003)(71200400001)(45080400002)(9686003)(66446008)(478600001)(54906003)(86362001)(15650500001)(83380400001)(8936002)(5660300002)(2906002)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JHbRB0laXUs0v1N8IS9W4aBw2UEqnpXNE65DoyUtTYTjDTURqNSSmITREDUt?=
 =?us-ascii?Q?mc08tAEKqbecKkXcIMbj8GoD6jy01Thtw4xRwspjFgm9l24NHWNqubKGZPAn?=
 =?us-ascii?Q?ETMccc4Kl9c35qQf88lTrYLGsZqGo3MPUKatW0947dYp3bVmhoBK9CR0WCLX?=
 =?us-ascii?Q?JHTpL90Tty5k6SHKAepZ0wdz8JDek/bEzqp6hMfnN43bt1agr5UIg7eL0SW/?=
 =?us-ascii?Q?jFiGAmUlyUikQYjh+kVx5G1Z9Et6EpGt/mbFS15XzmERckGaL5COxz36vAVA?=
 =?us-ascii?Q?2Jnq557G1znqacH23jI2ScK+BKEXxyrzYeSstsT9CBBelB6L2XMlQ3kbvctC?=
 =?us-ascii?Q?GbOYmln3Lfqqlk1MikrO3HvbwGeb3ZC375dieMj1i7RQG0mtUlR8LIrxt0cj?=
 =?us-ascii?Q?dG/MXF4VFt78+aayUzHrpIgpHPChpgQBjAf8u8q9wqN7S6nde04kAuEoUCur?=
 =?us-ascii?Q?4ckOsTX/MU5lVCknpPGUq/Mb+Zc04WPInDEc7uTwbakNOQ0t+j/1tTbmQaig?=
 =?us-ascii?Q?84cB2qWoijYkuITKNWt+Z89nuq8MnmzY8rGuSyETtcQXJbvSn8ZzsTSORyQx?=
 =?us-ascii?Q?h3Ef/g7BDD9oGa6VnOG3nqyj0VMVs3rbiuRn456rpzyU44oSTQUot8w5rdYa?=
 =?us-ascii?Q?A17YG3KQMBrQQfYmeUEH24XINZOJgBZcpPi2kINNgGEqJtXOvfpWUEBbwRW3?=
 =?us-ascii?Q?Q6IEk6iufdXEpmXFFLqTNSNaVT7LkNdRkisvGEy17HT+hSr7gye8kImTb3L0?=
 =?us-ascii?Q?c5w7bcFXAiCI6rA18aiLwuGpR2xINoi85Fq/6kEoMli0XfWixJwLSKH2sAhA?=
 =?us-ascii?Q?SAT6yi+M95nIXMN55/ZKzY50i6iNn587kNAf8kd2tL8WyDgkYX++xrjblw4q?=
 =?us-ascii?Q?dcyN2zymXAgiT0mdNr7V9HrCPvWsaXbm1V3SCvAtu5VUXVTlYUfidQp6pd6r?=
 =?us-ascii?Q?6aZHbdgj01jldtMjFo+VDwR2bBCl9JNEWt+/mctmXp0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb60ae1e-571d-40f5-5722-08d8b764ea16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 01:45:32.1222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1/gp6i0Ior7oE4nickVe3UP7xGYc4454AuhHuheHU/S+ou3hQHPsgBx+wlA87uP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3351
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
Cc: "Hou, Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

This can fix the problem of the below commit.
But I'm not sure what is the real purpose of the below commit. Or can we revert it?
Thanks.
commit 72a33b4b7433780df5334f9cfb23ff51669431a0
Author: Huang Rui <ray.huang@amd.com>
Date:   Fri Jan 8 16:27:15 2021 +0800

    drm/amd/pm: enhance the real response for smu message (v2)

    The user prefers to know the real response value from C2PMSG 90 register
    which is written by firmware not -EIO.

    v2: return C2PMSG 90 value

    Signed-off-by: Huang Rui <ray.huang@amd.com>
    Reviewed-by: Evan Quan <evan.quan@amd.com>

Best Regards
Kenneth

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Tuesday, January 12, 2021 6:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Du, Xiaojian <Xiaojian.Du@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: fix the return value of pm message

[CAUTION: External Email]

0 should be right driver return value, 0x1 is the right firmware return value. So switch to 0 at last.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index d7d86fd79e1f..41d5c65a2f21 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -149,6 +149,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
        if (read_arg)
                smu_cmn_read_arg(smu, read_arg);

+       ret = 0; /* 0 as driver return value */
 out:
        mutex_unlock(&smu->message_lock);
        return ret;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7Ccb87272dd89a4b4a6bef08d8b6e463fc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637460439339749600%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Hzm73NA1Y%2FSS3plnWpZ%2BcOxyIvEnySRBTTUV5%2FV6Lxo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
