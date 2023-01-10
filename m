Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C89C54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 03:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9929110E523;
	Tue, 10 Jan 2023 03:46:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2599F10E523
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 03:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqIMYkYtOVKmMEy+pHbplCCii7/nglJq7rU0fCeOZpbRiigWaU2+hyXSX0U+qrbOOYuMkKrnrPRuKaFXyl48c7XrRAt5kewRBMtXp7mNg8y3fnWj71kHagINR6btseSZZExIVUJMIVI3YyJaufeOtyTenZV1Ic5PVQlgBIkOSjW7KHoTfzgm7A/E5gRzEQqpFFJ65aKigMHLE7YjsQqyuzAFyKRiITxXHLqP+rLqziv+kRlO2Gh73B87Uap41PpTKWvQKOqi6KtRYi/XFYWSDyqceiFM1IROxWDeN4bYWy/cRFcwBeBWlbz62NsrIby1fodUTDouCKgsZetpOTwBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkulB9LdHSvTWv8D5Ar8RaFidwypYrY/p2Z9JPu8P6s=;
 b=cuwKOMn6Hb/JIWbUeDOV9lIWXqzOEjGTMAO973aZpGC1DO3qKm3OBBYsF8OvhHj6kOkeA2ZksU/VTHVpEUEAzJKeIaEm4mmjf/5ToufR9X23oJlWHuWhDCXCMX2hjid+GmBvUMWmjML++8/Brf1I16HiOuNUntcWiV/Z2k+otUGAY8RuXu0DdZWQdz6Z5Il9X10yJWnLvDvIA4nu/lW2idcCYk+VsPztf3WtSSVQmbwAoOL+fJj5t+8kHoBxRirS5uGMdlvYFYWgFX6njtW1z4NtkLixwwIhqW4RuO2GQqp2jHwX9vrdfXAonbNrh0hywmPqRJpXDY0uYyKmutk55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkulB9LdHSvTWv8D5Ar8RaFidwypYrY/p2Z9JPu8P6s=;
 b=JGwFN2UYgsnS0dRk7jX9zeWBeekM0w8wDHKNQuIsD3h4GPEkOfiEYPUyjYN2bdH+VUHL96PdDyT7ZooXY0ejeLEG+dycHNuckO7iAPgKTU9RPOMskSUNBbySyp3Ta32RlXDVLPW4joLjUVha5IBTvw3xIqlUnRRHPUF5Ai58KMQ=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 03:46:42 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::dc1c:f435:1cd2:7304]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::dc1c:f435:1cd2:7304%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 03:46:42 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm/smu13: BACO is supported when it's in BACO
 state
Thread-Topic: [PATCH] drm/amd/pm/smu13: BACO is supported when it's in BACO
 state
Thread-Index: AQHZJKTx91tX6VdBd0S8ZGPXO9ZiyK6XAsqA
Date: Tue, 10 Jan 2023 03:46:42 +0000
Message-ID: <DM4PR12MB5165F541DC928BEB968421B18EFF9@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230110033733.127420-1-guchun.chen@amd.com>
In-Reply-To: <20230110033733.127420-1-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=aa1e035d-bc19-4d90-8624-98f8674e000e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-10T03:45:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|PH7PR12MB5781:EE_
x-ms-office365-filtering-correlation-id: 139c021a-9750-4185-5d6f-08daf2bd4994
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WwtsWjAon1QV1Svi5HF466QJrRYvGLFuuNb9ThwnzsXqUMyLs+y/wPfr6f9KokF3l9WI9d298USOTdPrvW0zm8820vpD5plEKLX+p0KtayQfabIeJYq8axgF5WIoAwBaFE8OG65ZjIhoxrNc/6ckoSVUGnYFf3I/YF3pabaSiiRm8+2p4uS13Sa2LmVrXZ6K0eJbiWSPk+hHy/eMV3vSid4WJCj8XWcXug5WiEa97hEgzTx96BTi/hp8hpILxUsv7WMTY1bYxQs1n/HUERH5ksqp0b0q/3hHZPg2awj450fO4udJEddiOHKgRZEb+xohdMVXOBPfrCnyfN4SJLq4CHmQWwownjsKiCXGpq71zNKialphtu0FQQHfSh5Ya+oPKGvf+2zZNHmoZtNXv1wY6Jh0sjffhD9LgjFlOdr44jcYZPESigUic2/mzG53ce7yRx/CveRofJNzzu5tnQMQYDURvjPAnMlRwk9Mwu0gqPPlV07t/NxWD6VHs0u4+Av5KmCv9fBPkJd82Tq11w1VsoMmwt8tPQvbsq6CRMCZWdvp6Hh36Tj/va8ZxE+W6C3KjNfT0NSXSadSRuJA419/3yyexE7mPj8GprJA+3+6Hw/QyDJu4iLEYMCGxR/4uGWtKLDgdYJHRo1nzwF4JgZrt/QDagOqSDNk4In1Eo7VwWIsSYdYelkfqtULQlfEkMvuzngVh4+6jIgj4gC25L+jT0d+zncsKpEO7zTS6W7MdJc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(86362001)(8936002)(52536014)(33656002)(5660300002)(7696005)(83380400001)(71200400001)(6506007)(53546011)(478600001)(186003)(26005)(9686003)(921005)(38100700002)(41300700001)(55016003)(8676002)(64756008)(66446008)(4326008)(66476007)(66946007)(76116006)(66556008)(38070700005)(316002)(122000001)(6636002)(2906002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b3N2eLnSHlXq52xkRJi27icK4YN3DivVxfCkKo4s97SuOn24tsCVFx8sgMdF?=
 =?us-ascii?Q?VALuKBBWGs12wfjela6bOi/IdBlAC3TIYRUyu0eupTXXIdlAoS2s0+iaIjKN?=
 =?us-ascii?Q?lQQZsZWjPnLidUetulR3LsH9jrT6qFktndgZbKXMhNiq2PZSkxE5ZGKp6IX1?=
 =?us-ascii?Q?ht4We+6FGbdxR9qw6IRN/5Xqi6BJ6n8/blB52kCqR7cYLLWrJoXGMjltpQ+I?=
 =?us-ascii?Q?VGkWvflxl/FzpTSDw2jZnN2TxMaGp4jn2OIMYkFKAfmlTFctQDj8G52SBTM5?=
 =?us-ascii?Q?13YK0jL6LpW8TzRkcT6Z3xYpYisG5pj8SxKLd9rNu6YU3avnd5ii7ZRuLMQx?=
 =?us-ascii?Q?zEHihlVyMSxTyPCyaq6tDbEppeSJbkuvkla5Ymi//1iDnTByTQmxk6qK/yLP?=
 =?us-ascii?Q?VsmXwEXmGDOaJcrEiRpzXuttjiQ4P8uktZ7/xxNcLrl7Jl9sALryUw50IDuo?=
 =?us-ascii?Q?Id2lJcsVL+l2Y5gwmaMGuxTHTF0MvLt5sKb0NxPh0mXWxL4PSRhv8FGlw0iM?=
 =?us-ascii?Q?/HbtCbULqzcyuOvcZylkv82i+cRo0PYsZCKDEbs7QQQq+JjGSm9udKjZvo6w?=
 =?us-ascii?Q?Fk/5bP3sKBVurV3J8eSN5Fovrxkpe+1oSx3i0Mm9ZDyjIjimDUnxDVvgM3mp?=
 =?us-ascii?Q?3N8RoV+84MpAYiRvLpHjszQGIrBooswuvm1okhVxw4phfsluweU2w83rasMR?=
 =?us-ascii?Q?BkhJgwT9XAOO3Q2vXGfpr2b1eSVt+XBfw85rjxs7uOlmysXc1sjKIuoMhYZC?=
 =?us-ascii?Q?EHWAhMfKVg6dlMQ6voHpMr2B5q/iy0BYbNhzV81ZYkXegCY7vm6sbPUfxGNW?=
 =?us-ascii?Q?O6tcFSCLi6lerqvsd+DyPNfV2xBxi6BKpH0q1FD4EnmWOr62KpsW5h5fia6t?=
 =?us-ascii?Q?OBNA+CYoOtpPuf3Yw87eRzVbQm76h8qRLGPoLMnG2lF4GPC8+ypSRWNm0JHl?=
 =?us-ascii?Q?mJYYUx6nZbxym3FJMaHw5GpWG/thTIkSOItpq+pNaVLL5h9tsG7x/qu+dCxS?=
 =?us-ascii?Q?YJBAtvBPEQJCM/mj0vDknl6wTzSxeeXb0uZ1bjJYQrwV0kO8JkE3Qv64ee9S?=
 =?us-ascii?Q?T1WV53yLwVBLcGHIBa+vTUsurZZLLzHhoQJf/YmJIjK/WKP1fuH5hxe0zc60?=
 =?us-ascii?Q?bExt7vfAknBDFqRAxRmH5o1aG3jlkxdto1GmhxTNF5ZRTXE9sNqQGcQqqGbU?=
 =?us-ascii?Q?lz9Ctc0GM8N4Li+8qwsADqeOvjzcmVjLsFClEFeUTr0OG7MSxCnD9lI1vGV4?=
 =?us-ascii?Q?EaqEAyX/hCMTBSF+pBcyod95E8HrjKt973rIHpGt6csfbmdGVwucsGzdjAl/?=
 =?us-ascii?Q?rm5Zf/I+NeVJyZqsv9Ul7Lsg0kbreLen35e5IFNMwCNhUbH+MBpoaOEAM1lT?=
 =?us-ascii?Q?2fQGucVOW4AMvE2shSTSJAPUAlFVlVUHl/mRZ4v7heucI2NZS4bxgIVDtn6o?=
 =?us-ascii?Q?lBwThAavLARdigkXt0Q/0VmNSTxZThVmiD61dIIhiZQiAOu+OFvX9j5gvesv?=
 =?us-ascii?Q?aZAG+aAO14Jcbtej4EEEwn8fyVAuTxMk2qCGB8qShVtapvBMireNQZxreYXc?=
 =?us-ascii?Q?3RDdrQjtATQtSdNAivc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139c021a-9750-4185-5d6f-08daf2bd4994
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 03:46:42.3235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTEaYPfwNPAkFQwa599tv7k0ZZu21ZpwOqo+7yskLtZiHbz/ll9EClwCdz7r5RyH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

It makes sense.
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Guchun C=
hen
Sent: Tuesday, January 10, 2023 11:38 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd=
.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/pm/smu13: BACO is supported when it's in BACO stat=
e

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


This leverages the logc in smu11. No need to talk to SMU to check BACO enab=
lement as it's in BACO state already.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index ccaedfcf977e..78945e79dbee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2243,6 +2243,10 @@ bool smu_v13_0_baco_is_support(struct smu_context *s=
mu)
            !smu_baco->platform_support)
                return false;

+       /* return true if ASIC is in BACO state already */
+       if (smu_v13_0_baco_get_state(smu) =3D=3D SMU_BACO_STATE_ENTER)
+               return true;
+
        if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
            !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
                return false;
--
2.25.1

