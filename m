Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA964C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 08:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2D620771
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 08:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="csXklzII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2D620771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB026E2DF;
	Fri, 14 Aug 2020 08:49:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1E46E2DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 08:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/nuXnsFoK8vruJvdH6rLOclbO2KkFPED1sD7NoEVoEps+sq8PFB/hA7zqSOVTRNUQ/eHTqVjcOf+79dkMbAHA25Bp0cxscIKW8X1gOreWTmsQl7F8GLglVv/zG7aPHggKTRL2yB3tqt1qWRj1brhnytp36B9UEDwkw1wseMJwVq7REXsWp8cWQ7LGsSPlsyro9ZS6TulHb3N/PPg3n3NuaTM9hgUKtv7oVZIImr3LTMNIkogwjtCnxGPBSt3pLGxMipBKpF0ilzb/snfb1OMF/epBSlOKoyJIj8S6IwXI6Eco2KMdqb9/gUnO5poNr1pE0nAusxJl+QOD7D1WF35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiAmeoYGMGTR0UqlkZCcBPj1l6wSUgmXQDmnh2VKITE=;
 b=IyZQV8H0u7t2hX4hSp6Z5xN/nmJZIshJyRzoQ2a4xyk5ySaFCYiYOMGeXgvmdIvLGZsN5RxqIGBd2la133Rmk/liimI2yMTbmKltEUs7uLaVpdssk8FKNIvdzFFjL8tiOefi6+2dU2zS5WM+kf8knVncRla8Se5plI3CO5EWsH7WuzKWVCezAfzXWdy99p3n4DAhJszNQ/2k+0Nz7QKir5Jpwm6vm17c9Roag4VQiL322m3EWwmU/fND/pcmcnc0QA5Q5YVqWOf72bXmHtZHPIe5xLdoXHMyQmUZ45+sTh1hVaXOh0AQ+cRFbR1MrNpUVL9PXLn35r6T/W4YnW8egA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiAmeoYGMGTR0UqlkZCcBPj1l6wSUgmXQDmnh2VKITE=;
 b=csXklzIIUVx7brqBRXrxQN78BCf+TJmfgPJrexm7I/fc8HOvsihrt6qOCdyraLWSZxGpUfdFEpyTRgIxxMmPdxx7lufdSaJps5tHCc8Emt38fHlNuTdTRy8TlmFa9I6J3J7Jn4b4VUVUy/bHjMPAV8GlaSYix0gmHti1DAeLQnI=
Received: from BN6PR12MB1619.namprd12.prod.outlook.com (2603:10b6:405:f::23)
 by BN7PR12MB2769.namprd12.prod.outlook.com (2603:10b6:408:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 08:48:58 +0000
Received: from BN6PR12MB1619.namprd12.prod.outlook.com
 ([fe80::d06b:25ac:463c:10a9]) by BN6PR12MB1619.namprd12.prod.outlook.com
 ([fe80::d06b:25ac:463c:10a9%7]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 08:48:58 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: drop redundant MEM_TYPE_* macros
Thread-Topic: [PATCH] drm/amd/pm: drop redundant MEM_TYPE_* macros
Thread-Index: AQHWchcbIBrR2C8fGUe31+XWeLzoV6k3S0Zg
Date: Fri, 14 Aug 2020 08:48:57 +0000
Message-ID: <BN6PR12MB1619617FBB207815DA7BC2A6FE400@BN6PR12MB1619.namprd12.prod.outlook.com>
References: <20200814084355.3440-1-evan.quan@amd.com>
In-Reply-To: <20200814084355.3440-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8d990af1-a332-465d-b302-29bb26647456;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-14T08:48:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c305f233-bc6a-4b93-7dca-08d8402ee243
x-ms-traffictypediagnostic: BN7PR12MB2769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2769B6671B946DEDD24DC575FE400@BN7PR12MB2769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00N96o4CWReGI1VKMEGJeZMFBRm4DEkCCiUhw/Gc7Z7O2S00U3zq96LJXo1FmD2Gkv9rpyrGEW61WpEOYu9eQd02pxSaD/Ml+Jx2d1cdwCqj/i2U+1nwbTHolq2OVQ0ympMoczlhNYSr20Zi1oBPvK/NWQ+J1gO66YpL/IBWjRFc1Y5l3nefTx/4qu9myulIn6jP+2Ap+cxKBpDW49E3DmP/KWXXzwppFWskHY9mcOks8R51UeyvcseSkwWLwTW1zIgLUk0BY4xkpYUo4TelCqX4lJ9o95aSp7P5/+ubUhyjTzApXsvsvi+RS9j4dpSCbq8RHrHSq4PCVmiSuR0SQj820eYSPyzFkdq5qEYQsI4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(966005)(186003)(2906002)(45080400002)(478600001)(53546011)(6506007)(26005)(7696005)(86362001)(83380400001)(4326008)(71200400001)(64756008)(66446008)(33656002)(66476007)(76116006)(66946007)(54906003)(8676002)(5660300002)(52536014)(8936002)(55016002)(66556008)(9686003)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PUz1tNKQF5kBw/STE3E4wzN4Y33CDC/WyU+DlmNt/eM2il7LbxPXX/yN3mTN0dowmXHPMuhcX8eSdIj52bv+s3rVvp8f4edE+D4f3bYRSUVxocFlu52Rp8bdYgDi6EIi81R1oaCnyiqlqb5iOkPJ9Ak8UK1HEy61dfkWA4rhrLIppd5KCL2nlgqPG8DjILIYYTtBKD/dhnKUc8cSn/5oHSp+HdpZ/WWeV13LEGyFYm1hf/LGo7XHqq0MDqY1wGRjPQ0KQRpLIJZpiGTPGb1Hhzo4BxCOapc1fQMAGzfF+hzJkPY/ytmb8kIRcIp2R5BEhpOHCN0ZSgtz4PFi42upVGjqYcUyi2UjSFNxwj/fbuZM5A1vhH3GLGLxt4dewJIdCKEj7QzYKiJ1wqaaBpyBKRHIBWQQjNefQjkBMsNFU0qfF7HsGxfhgsbl8SM2sLeAounReo/lnujOPbyqVR4st+ej95NivC3UhP7g8DaVAU9Q12xmgurgQyA2iVaSC9YjNtac01m4o5Rn7O36vOdNV6oFToc0tavIrcuzYPvJc8aHO1luesIzGACEYqOsLAj1FIafttjcI7J4J50YYxWV+hTvpaYisEc6AHxuEaUx4zwkBqEDKd1Q4316jgqp5JAYuqsJB4rtx8S2zmyJ06HYpA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c305f233-bc6a-4b93-7dca-08d8402ee243
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 08:48:57.9823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOcpHDT4BmWWWRQi+vvNhaAXJSuEqE+QZi5zMqRODB4/AhZYlFHN1gbmNuFtChJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2769
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Friday, August 14, 2020 4:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: drop redundant MEM_TYPE_* macros

As these are already defined in amdgpu_atombios.h. Otherwise, we may hit "redefined" compile warning.

Change-Id: Ia2a9e10b35173fedcbbd8e0abb8ad38dd231baf4
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
index 3ee54f182943..76ed2e413594 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
@@ -26,15 +26,6 @@

 #include "hwmgr.h"

-#define MEM_TYPE_GDDR5  0x50
-#define MEM_TYPE_GDDR4  0x40
-#define MEM_TYPE_GDDR3  0x30
-#define MEM_TYPE_DDR2   0x20
-#define MEM_TYPE_GDDR1  0x10
-#define MEM_TYPE_DDR3   0xb0
-#define MEM_TYPE_MASK   0xF0
-
-
 /* As returned from PowerConnectorDetectionTable. */  #define PP_ATOM_POWER_BUDGET_DISABLE_OVERDRIVE  0x80
 #define PP_ATOM_POWER_BUDGET_SHOW_WARNING       0x40
--
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CFeifei.Xu%40amd.com%7Cb57418b0630d47f141bd08d8402e3bdc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637329914622450013&amp;sdata=uuHzhQ7DDnANxqLtUhx%2FllmcFXg%2F1qPNzhQPa93IFdI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
