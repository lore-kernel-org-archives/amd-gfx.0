Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA037C0015E
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 14:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F8D10E3F8;
	Tue,  1 Aug 2023 14:07:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CECE10E3F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 14:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTiILPxX4Nf7CzsmxfxeQuTms5nfXWMYqOdHh+5g/6XpXvWMLG8cIMV9sP24ev1GFykF31HSfTFfhSxRucq13yfquJvIGBJJr2OrdWeawmDE+JOBa6xbn6iRRVHzDW15eMXRdtURcJwPOY1Re7DrSLBppsbCB1Q0Y0q2G4P2GR7GXv4YYRwfQbfT1ILXNd/U3pqWBJlpgpkIS2qBOuVB0pXM2YCLXWNn5nJZHmwKUAfab7LsDUQnBZTm6vfEYDmLRdk+NR3SvXCTXDQfDlhhG68iKPCYO8HSoXaYa0+7MazzayShoE/W/5NxNgvFamq2PgFY2TsNVRWPg7qXfG5WsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG0UgwLleXMleP7Lptr0y6zU/UMhF6/xpM65xcXzEhM=;
 b=fePsakTULJXE2vwyP7UxvvTq9v1PcX6NycTX+ec+QYB+07hYOwaoUarAHYnk7Fj0mECNNmexvjxz5q95uC4bZadYleMGM94Ozt5YyulQJkHtf7dcKxhfPwLeLHNhgwVMkV/eQV7qT530yCwSGBLGeySAY/3Q9HKgP9CZcsSUYW+5mXuyQb9xajDTfxnGmHionE3L26tS13dpjgl/b93haC839pCPlmuDLJzAzUyP7HQYWEC5d2zwV6YU3KwEC/OPz6rsxUU3/0BIHLaIl6pMsfhOqLS9h3DLvZ3jjeRg5y3Xp6uuC/YFLRr3cQKIT5WcHXzat54uriMqCmyYDuXzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG0UgwLleXMleP7Lptr0y6zU/UMhF6/xpM65xcXzEhM=;
 b=FH0Y4Is4lh7bsLdoexWR5mGCN0McfxHVQYZEjroLIkEpzoTHiOW166ZTLk5ZHmfAWZj+UNa48VSjvDfLwMuY7ZFKgkDrsH8Hx6xLRV93xgGkPzDrpxRIcNFbFXwbfeOlUlnvDQl+uinAmdePXJMj1pQ9BSIDb7qacZglCMVKmgU=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 14:07:55 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::c377:a09d:c286:5835]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::c377:a09d:c286:5835%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:07:55 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix variable dereferenced issue in
 amdgpu_device_attr_create()
Thread-Topic: [PATCH] drm/amd/pm: fix variable dereferenced issue in
 amdgpu_device_attr_create()
Thread-Index: AQHZxFjr3cCXkI6lTEigGM+7l87omK/Vekrw
Date: Tue, 1 Aug 2023 14:07:55 +0000
Message-ID: <DM4PR12MB5165215393FCFE2DB21E98568E0AA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230801091628.3689529-1-kevinyang.wang@amd.com>
In-Reply-To: <20230801091628.3689529-1-kevinyang.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=39fe584d-62dd-455e-9b1b-607a4d81f0d8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-01T14:07:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DS7PR12MB5838:EE_
x-ms-office365-filtering-correlation-id: 17f36791-a167-447a-2a9e-08db9298b3b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOymPMZ43vZF74u1yywnFQwctMLcbUcyByW5h43kcNHQUXq0W8xiAUGHdu3l+ewqbQ15N2rrBddRwzUWsm+t3WOeySklr4LCL8IZkCmeqiY0kDTFIc/kEc3ycAIlaCupmHTUtZYEnMBQFG3YPw2rhjuHTluuOle/g8BFxxxELu7IQqsNfidsKp6LucBVVMjtoadA6J+0u1FiL5pfYg21DKoz6TcAbHmpBudWqVD994ysoyK8lMVuyidhcgzxM5ENYN7Knj1ECdsXqmKqqe9ZMroS/DGF3a03Eyyo5T8fokVA92hqAwQpMwfm+BVS16F5T5vsfb5jFzDier9z2pXv8BdlPsfgoWLdeJ9lk9mYjkYGhsDySXOGfCOO4jshD/1vfh58yc4PMhRoLtE2nW/6pQNWkfqwfeKUbzWry0IA9mfdvrwgYr0khVOcH/jW+clENnaHo2WEBoEAkq1K6p38tHvzccz2B9e7tHyGEuAkmh/AVD5Okb3gqQNerYqKHu74Lf91Zpv5qHyEDP/65JlsJYbHIvdVp44pOAfy6o5QMous220AnMwqB+cSb4chK8pjtumdtqfrqGR4mnBaE0dkYYxVTZqKk8VSV/VLYjH5oUdCwrhogTiq72nKctcFetie
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(478600001)(54906003)(41300700001)(26005)(110136005)(186003)(5660300002)(6506007)(38100700002)(76116006)(64756008)(66476007)(66446008)(66556008)(66946007)(52536014)(71200400001)(53546011)(4326008)(316002)(8676002)(8936002)(2906002)(86362001)(7696005)(9686003)(33656002)(55016003)(122000001)(83380400001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ug1W2zoybRweG/urRXv29Q4NkrmMkOBFw+LKBSxXtemPt2PQDagaCcfjnQ9I?=
 =?us-ascii?Q?BHmezwEmdRvpi3cD3/Jy3h2VLy6/xvspsmZkDIV6fNT3cgsb/BlvYy5U424z?=
 =?us-ascii?Q?NRViKtTageu5NgVPCOXIxvX0v7lqmOWuNgSpwIYrjaqQEGifKPdPJC3g2QS/?=
 =?us-ascii?Q?7cGjG5giaHX0IiOxa7NLlpCK0hZLN2KPoMp3B9UhOD43a/Sy1gVlMfy41TVL?=
 =?us-ascii?Q?Lo7j+KWJ3gTRHBx2kVEPLxa5MmnqaZxq7wAuUYR97RBmQ8QZfeVOX/9d3J+x?=
 =?us-ascii?Q?/l1xHh1UYL9PWK3ZZyLWrpH/jIqnBrswJG7fAbcCiv0ftde21aobdv2R6T9o?=
 =?us-ascii?Q?A4+fbBLJp8xOzyiwfN1lUAAJZbiPhIIRq2iqhLeeRh40qN28gDgKWa5YSnPD?=
 =?us-ascii?Q?w3e2EF3QxwZhY0n5LZ0FqD2987Q155bdC2ZXZ/NeyL+YnWmORaj5lfTTlv0H?=
 =?us-ascii?Q?GSpKM8kTXM/j+fHEExntRWIyy+0bKEMH1ACCxuPFMA9j+sRQ9D5GKy180Vv/?=
 =?us-ascii?Q?41a89Z+Szn/tDTlb774/XzZ3I4LSMCcK5hpvFp75TPzdSUXOZ0vP+8i3U1IK?=
 =?us-ascii?Q?LGcQ2L4aML/PEN6pmnaOeKI49c9LhuC3m71AM1AocAvsx5PuBxuuc1I+lOst?=
 =?us-ascii?Q?XNpkgGREfwCvDsxEUHDvB+AClLatrcbMRfh1I0L1ka0b/TRepzpRNelB2cmr?=
 =?us-ascii?Q?oG96GOp2tulqxbV1Qp4F4/KQfaH3hdu2+PPU67MOQAUBh+VXhTuReBbPlZWE?=
 =?us-ascii?Q?SMoHFOY+VMSKRTdZRo8Fz3vFgDAih2vlLZxe8Bc8dxLrjBovNBYoAXWxP+4c?=
 =?us-ascii?Q?KDcuOcu+faCA5NGBO1G0+vseBbxZDs4Uv4iEgDMAGTysuxUARWSeXhD5nY51?=
 =?us-ascii?Q?K6l7koCObuBq2z8PqlO5qNJ/spAfPGZURqipjIISwzmkri+uxBhiuWri5l5l?=
 =?us-ascii?Q?Rt95hWx+mnDzhugIumAttdCNEH2p4VBGoHO5sCXU7q4eQ7Jy2h5RrGODeNrS?=
 =?us-ascii?Q?kO4b3uG6mWYFB19MC6fckmPSzz/Qex2Pa2XHkVcmfhH8WPVcXtfYS2DtlKaJ?=
 =?us-ascii?Q?TK843xbKpI3ZHLowUGyct0ckuQFFSjtkAWLBQZh5taqzFp4dtZCyyl9HlThs?=
 =?us-ascii?Q?YbmanmiuoQoyXk5J4D1Q4NJmdcgTqauLJiIESTDlwMh7RXyhpUeFJL/gieYJ?=
 =?us-ascii?Q?yJwMePsNpRZiK/pwBpxZy3B7IglOCRULwiRO0kqgbAGkyXY1J9nH7FkxHEhO?=
 =?us-ascii?Q?AleUaDSQDbPbsoiMZlKwJXSwc5nMD6iJ+Qioo2vTLdaCVyM1yEqNWYrArqwh?=
 =?us-ascii?Q?Yhb3vTYwlAMFWu3ki0vY6ySWnz8pNumL0XC52T+7Ew4RhYsWZW0GASye73ke?=
 =?us-ascii?Q?TX+Q8IjvhA1r3srPkZ1wAqvb95+jZLIV8aNrX0jMyhTCNsS6qNZC8MSaz8Gk?=
 =?us-ascii?Q?nebbE3jHJdkY8+tfxhp3oNk4ROsi3o/8D/FHEtvvKkPCUK5BAWHzWVPWKy1l?=
 =?us-ascii?Q?6dHNQTVCXjDzLaTyZX6k5aA3ojZrFycwSgY5G1uCP6FckqNun1uMOtXQzkU1?=
 =?us-ascii?Q?hvVdZWt0CE4IMND0lCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f36791-a167-447a-2a9e-08db9298b3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 14:07:55.0329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0mFV7d6gI+MEY6et1NaH9H2gB8SwLrie8wVg/aV9Ep2bWmLUoh7HITJjw/q/El8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Tuesday, August 1, 2023 5:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>; Wang, Yang(Kevin) <KevinYang.=
Wang@amd.com>
Subject: [PATCH] drm/amd/pm: fix variable dereferenced issue in amdgpu_devi=
ce_attr_create()

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


- fix variable ('attr') dereferenced issue.
- using condition check instead of BUG_ON().

Fixes: 4e01847c38f7 ("drm/amdgpu: optimize amdgpu device attribute code")

Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 3922dd274f30..383b2b778456 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2171,15 +2171,19 @@ static int amdgpu_device_attr_create(struct amdgpu_=
device *adev,
                                     uint32_t mask, struct list_head *attr_=
list)  {
        int ret =3D 0;
-       struct device_attribute *dev_attr =3D &attr->dev_attr;
-       const char *name =3D dev_attr->attr.name;
        enum amdgpu_device_attr_states attr_states =3D ATTR_STATE_SUPPORTED=
;
        struct amdgpu_device_attr_entry *attr_entry;
+       struct device_attribute *dev_attr;
+       const char *name;

        int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device=
_attr *attr,
                           uint32_t mask, enum amdgpu_device_attr_states *s=
tates) =3D default_attr_update;

-       BUG_ON(!attr);
+       if (!attr)
+               return -EINVAL;
+
+       dev_attr =3D &attr->dev_attr;
+       name =3D dev_attr->attr.name;

        attr_update =3D attr->attr_update ? attr->attr_update : default_att=
r_update;

--
2.34.1

