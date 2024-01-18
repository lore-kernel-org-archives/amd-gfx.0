Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3E5C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 06:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D625110E048;
	Thu, 18 Jan 2024 06:56:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC8E10E048
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 06:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzxUK6O/gVR1NuWuK9ZvmbQny6R/cvMqTu5DaeJPfKF8s6u5fBs0FvPEBpy22gi11RC/kp8D5h/Y8KrqXH0TkJhHu9u8SKdpROMuCmJG0Jks0Q+aLlxCNQmGAS9D0tt4cjvNfSYF0yzSyusn63aka/R5KZlW+NNs2JvoBhKWEHdiI5AlgK8JHUmwz6C9Tv+8eYAUMxp8As876IFu/EPwjNFvqSihrdYnifK5KivNG0bMTeHcE+2Vi74FT0Ys0XaXNfEYV7t9XWy1IeO8NPiqEP+szfnrKrJirPHmoHw6tcXwjMAnbozakOlZkZ1VX2YG9Etu1CNJ8N2bfW0B/8dDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PWfqWN6+uccrNb3sVdsJysesxIvguwxKVadIiMDyyw=;
 b=WADWQZjtER0x4/1ynS0+9mC0LPB6WMWlAvOlXnjr/pv0BUtI6mSuS242T8y2xjWNMOmYA/U/cSfz7QWEWlzOrAgxO9UkZYIEusx/Y6our5+0fiDhwzmHQkrnKF8O+9ukqoseVzfUkKr5gMC+yOCQ636OCtPRoj7CZ7byJSjNP4L8bM0SeGY0a5HCBmRnGP41GAVCmiot2hzKz3TmqcPvsgx6VY2/EMByXUkbDbF1+jPetIZAmnEIKD5fPp/7l9NAAkmER18lA4/nFjxd+vsDSv7++2QYR4j4HpQYZiwRKoyhCjCxfJV1ctYMlMW5oAZjPL2YNjiDbUnGpEk9oTA3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PWfqWN6+uccrNb3sVdsJysesxIvguwxKVadIiMDyyw=;
 b=GWvlR0ERDmNj52CYiPNFct0jZzWK3RNCErlln8juuPCDLOGVfojTYWUjmWuifxSmZLYXUigpCqYjMLWou/dr7q7sdWfAgGCFJrgLdaPfcCo5hnlmc8yM5fH2gJAkvdGmOo3XnFjzbdUA/YNLiU08rPeTZdrQGo+hah1vbuqyPMA=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 06:56:45 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::eaa4:8228:28ce:22a]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::eaa4:8228:28ce:22a%7]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 06:56:45 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: enable amdgpu smu send message log
Thread-Topic: [PATCH v2] drm/amd/pm: enable amdgpu smu send message log
Thread-Index: AQHaSdB3n5PiMti+TkCUx98c5kQ2hbDfI0Pg
Date: Thu, 18 Jan 2024 06:56:45 +0000
Message-ID: <DM4PR12MB516557FB06D02ED090DA26C48E712@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240118053711.1975928-1-kevinyang.wang@amd.com>
In-Reply-To: <20240118053711.1975928-1-kevinyang.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6ea961e6-2ae8-4656-9ef0-325a522bdf1e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T06:56:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM4PR12MB5054:EE_
x-ms-office365-filtering-correlation-id: f915c01e-dbd9-4c06-2576-08dc17f2a280
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7E3pGXbXF00UwR3yFgNZ1B3vmDMyKOwu08QcHU+3EDeQcApySC1BMzsURe9Y/0SYEfdsJO+VEkCod16pKcRsYxXh1XBt2ZuDipvb4lDcusNqEE2y+siH8C3zUdXy0LLid5d7XrjCbIs49qQLBQXCYc65dkkt9OAIqb+b5IXg+oKDRN+xCcitLUCSKPAMXzV76SSN0lU2odEmevWqhvJmGmWDqtQCDY+Jv6waCxocZbdjbyK+dW3SxWmVsOSM+ru0eZhWm63A07bvbwNwl54Opaz1un8hgjEAcVINfg364cutpUQzd7JuArCF2zaP/5BGr+yAOnWBk9x/m+Lxo4/PnOpjN9qUwj9KXVEmF+buAsS/QOrZODbYQydNtntWZcKUuTYnaIZRJeBw21KDd7TnLbvW1Xllkhsv39Dvp3wbkn+ltsDFz2rLYdWW804WNKzcWdf/klJfDm3LyvKvQBj1rUsmtIxe8Xgntjd0V1M7GVnPeWmhPx86dWYM9W2o1po73AYRT89qRPxEO2IUJ8RuwiVdxl+dcCKaA8mYIfWueFVpLXbmFDH7OWJru7SQ1VhzxdCKZUXUIy3WRx6DdUghq6TghQUbcQdkI3FqmbD9z83beUC3AAeyxuvHW7UX9t9Y2CJgIoHlVK+YxqdUp3gqlqG29zA33IENahGKJxApG4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(76116006)(66946007)(66556008)(66476007)(66446008)(122000001)(4326008)(8676002)(8936002)(110136005)(64756008)(54906003)(478600001)(38100700002)(26005)(7696005)(6506007)(9686003)(55016003)(71200400001)(52536014)(316002)(86362001)(53546011)(83380400001)(5660300002)(33656002)(15650500001)(2906002)(38070700009)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hc59kKgvMcX6on/3uordp+TrhRqPXQL9Tj54oVDTO+fYP5LI5/bXYwP+Z6Hs?=
 =?us-ascii?Q?K2pHccLhQf7aZMohD1A8BI1Xl0UIOy1eQl1d4M2sqtGpVDhdkpPfN61dsiBU?=
 =?us-ascii?Q?0q/CsSC488W9Y8BLFMgAfO6fPgfetuvuidCVZNLKna28dF+4kiaJMu3Xezjv?=
 =?us-ascii?Q?SZx3yvBTS07cs4yn6kW/1CqcVZlR+ho5R7OJ98bJNsSTFqT09PM0HLsqhwxL?=
 =?us-ascii?Q?HINUL4ooSydkgW6kovFBQUvGAIxcC7GwbtscP0V7sRHfDy65ZrrB8gsL90Tg?=
 =?us-ascii?Q?CL5B9yQzVAdwDoHRG8CaMArtpQfBaYt2gSZrz4oWoeMBUiPn7qfg5ZsQa6iY?=
 =?us-ascii?Q?1kypDw2ld3gd3Jx6tlaYOGscy7VdgydylNJ4+t9Mi8Vh2EOd3CwLVgy9zzHZ?=
 =?us-ascii?Q?xoGrq6fTNidLdDXGVS8SXkvv2FGZuYsegymrLFCBOIbFfsgLOu0xRkz+cWhe?=
 =?us-ascii?Q?95u0RmwASOmm02jhPgMhLTJhQ5U4qC2Hc/RMcr+p6meDM+8nhVBIHWFkEu1o?=
 =?us-ascii?Q?rOS5MhUGoujKDif2Fl0M0V1C2RcVigjF+4s270bDcfgI+3sDgWFIphXrCzKW?=
 =?us-ascii?Q?AMpI7muilQc0ezFCdanL3WoFMNddD52srTnJZkfSMV3OE+y5VD+gwAohyz7+?=
 =?us-ascii?Q?zN3HyZcHJMLQczhijcZ07j/VWyIcfIJLB8Tzem1fwTkBZih/fkXSgeZRz7Xe?=
 =?us-ascii?Q?TByyjQTyXBvoaCS+MKg8k2cKT3WEpmELKnW7loIijxq44YO9JNAgmKfk2NM6?=
 =?us-ascii?Q?ljtf3tuCNHRS+Ty7+v/6F1Zb0sA9AY0EWEcfUoqw1utQDU7F2vZvyfXHaV+1?=
 =?us-ascii?Q?OmViKra8DlZqFpWmXhoH9bRUjrYZIwBHE5tn3PQVtUufuXApV0O4bB/m1cuR?=
 =?us-ascii?Q?de2egcf1c88MJTisbz8YPoUgAnKT16ckGplwtP/Ql3+CrgkIPZEb2ErcqyDZ?=
 =?us-ascii?Q?8H4VdYLOFCf6CBUg1G6Ta94WYEJvydzfcYspq0G4tpdvOxFm5yJs0g6p/rgr?=
 =?us-ascii?Q?myNAqpXorYGEqsZNGbGRVRn3IPRaGBzdqFbSsOlKLicDUVW4CJ7Jv1mqYaa8?=
 =?us-ascii?Q?ZZOzUVxQbKSL7I9k9s6TWQtLsrNQ0K11g3Qdz9itKBBT2+t8R4LBVquTT4rR?=
 =?us-ascii?Q?ez2stzS8tT+VtsK+ZwETJOehueposTLKFBYTG0O+OvHsF3ZvhR/I5rtIGA2E?=
 =?us-ascii?Q?OiG26FbyXdsuV0EJH7fxXixDciq5a6buUtjdni6H4SlfHrgRdRVgw43uHvkg?=
 =?us-ascii?Q?AUmIpBmp9xIUrCwubjakouZkdiQi9wKgsJd9NqD0+2/uo4KmzQ8wjPArH5lQ?=
 =?us-ascii?Q?mV+CAoukvG1BFDXRMKykqkx3b4UF6E5lNq3Yl3TItJmwb2MUnf19HBwXZFuv?=
 =?us-ascii?Q?3oLLoWchDsFF13nfoe65IPKcH+bgb2RsnnzT3jrzqOua/ah64+WM9bZPsahy?=
 =?us-ascii?Q?nSTvPlMYGvPrsZ/BH3loQ/VG9ByI2at6lLj5HGM/BQhNZdTl5oFvPKvvmovr?=
 =?us-ascii?Q?T4PPFS0HeKw838MwlBVhv5uTH109D6UpPTbGMWvMf4s0KW+ogUBpVsMyibxo?=
 =?us-ascii?Q?HYjK2dR1+v5rVhV7n84=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f915c01e-dbd9-4c06-2576-08dc17f2a280
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 06:56:45.5584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVLxBicXk2LYh1jyCE1XbVLFnZj6HmyfQHdznfBds1/dlT/EbCVlPEryHQM4WdrR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Thursday, January 18, 2024 1:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;=
 Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH v2] drm/amd/pm: enable amdgpu smu send message log

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


From: Yang Wang <KevinYang.Wang@amd.com>

v1:
enable amdgpu smu driver message log.

v2:
add smu/pmfw response value into debug log.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 00cd615bbcdc..b8dbd4e25348 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -378,8 +378,15 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context=
 *smu,
        res =3D __smu_cmn_reg2errno(smu, reg);
        if (res !=3D 0)
                __smu_cmn_reg_print_error(smu, reg, index, param, msg);
-       if (read_arg)
+       if (read_arg) {
                smu_cmn_read_arg(smu, read_arg);
+               dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x,=
 resp: 0x%08x,\
+                       readval: 0x%08x\n",
+                       smu_get_message_name(smu, msg), index, param, reg, =
*read_arg);
+       } else {
+               dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x,=
 resp: 0x%08x\n",
+                       smu_get_message_name(smu, msg), index, param, reg);
+       }
 Out:
        if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && =
res) {
                amdgpu_device_halt(adev);
--
2.34.1

