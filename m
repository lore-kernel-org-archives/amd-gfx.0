Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E00EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 05:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9329310E556;
	Thu, 20 Jul 2023 05:47:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280CE10E556
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 05:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzwBxqRPwsE/Um8KQvUk2qCVf96DAjSMUWNK6Fhs/4q2AEieB9E9GrwbXJf4m2BEDh1EUBvfNIoRdQ7WbYDe7fZuIXNI0bFk01kHazhYX1oOJNdX+U56h2Bsw2mb8TcFp4D6qRVPJZvEb+o9sVZ+mrN5L9e3F90mmM1OJliIHSZrKSyvA1uivLZ3H62eNdl3DH2iHb1+OCu6r5BMx/DgMBQAG0ero3nMqizLAB2wvSrtyRKbsDWHKSWfK12v/yH8WqeRo4/sAbIIWaFhmNCzhOsL7zFR5bION5mMhvXHZSx/dOVeN0K86lodCCPkZuiTazdg7+Xe/LHWED6RKOpZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0SVUsOE/sesNM3BlRDMGbmsVjtGabTuxEOA8P9PdDQ=;
 b=aYKZQ+AmgP+JfDOHmC5BVuo5p7ID8PGZ+ZzazDJWl6HJqZm5oKpJg1wGDYe4sPlXQvE1Pd1zsncYU6Vzl1Pry8JHYjvNlacaj4P18Z6afR5SHcsu3Hwl0+A8nRs/kj78Nd6wjBdYN/cHb4rc+W0EhBzP3Dw9gMJFyJMj9UNh7+0yoZoDI9uEnBLIvoMrby8dZ+h4AdKeoJe0IY8CM+pTVviMSdEz2O3BrKMiF9Qpu2RXQfI16YuMeFyrcJkHPqHXM16xT0yttoQ+fMNTPRb0tTOWMZHeNCBXdIzTu/g6bXVxHFmkHXeFdOZotO2eNuiNBFrUOkdB5tezQQFoyjtOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0SVUsOE/sesNM3BlRDMGbmsVjtGabTuxEOA8P9PdDQ=;
 b=rQcDeLYar3cQJJkkbqOkGMdlYBVnIm7ZEAvhPBbZkWdyjceIiSvjlJrEoHKdHbDPSkAASL0fiCH40vkww0rYRiLkX6wid63kvE1TvhiEfzyzCLBg+1NFvzuXtKPm0Uc4J4wPJ989AM7lLLj7ZxC9vVkGZ4HmtRq62TlZHdaEefo=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 05:47:07 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e2ee:2947:91e1:82c3]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e2ee:2947:91e1:82c3%7]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 05:47:06 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix incorrect vmhub index
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix incorrect vmhub index
Thread-Index: AQHZuszm16Kmyr9Jokerkt69cxu63a/CJNkAgAAAtDA=
Date: Thu, 20 Jul 2023 05:47:06 +0000
Message-ID: <CH2PR12MB4215D47AB56A84F45BF45FB8FC3EA@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20230720054134.1187589-1-YiPeng.Chai@amd.com>
 <20230720054134.1187589-2-YiPeng.Chai@amd.com>
 <BN9PR12MB525775C5BB1EF817A39E54CEFC3EA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525775C5BB1EF817A39E54CEFC3EA@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7740685a-fa31-419e-ace5-00bc620c30bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-20T05:43:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|PH7PR12MB7331:EE_
x-ms-office365-filtering-correlation-id: a05abb12-bc40-4820-0903-08db88e4c080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQL+dbhkwFVuVXzj6FrmU8MPmNHv3Xt2doSdo6JeiJMSh2yBDDpHjkpl4+nHqZgmhms4dzRNbOhfODu0aJdQMcILfIYoW1Kr3Bkn2szoSHjLercdblfnGum928ctuFWl+/jil1njgq+cPeRD5D4M5CaodoWf0sd/jgucJjt9zKh6sAtlSE3+AvgR3kiZq4BxztLwS6vJb1kcYujKtBdmEVI4lHGXW4rVszs8HMAgukjwCqMJ7QLG0bVr1Q26BidJUY5bFLxrkWo/CzHaHXEbbPwoijVMzVNU9rU3pfGUm/DPUOYHPmMlwwgcUU23APw7o+f1oERI44/IMjvlt7eBE7t1p0AmLZbqwJxw0rnnDhbXHzFq0uIcRjRba1kKWDTUoK5GK9UIfwRyoiHR7sQrPujhPO/AKhecjV5ZHPKWZtm4BZypQ5Um1n3UjQgdviXsZUKJBaVsQS43PXAm6AT2qKh7YwNNA2ANXQyGy7Tb8S7Oq5mq9Lt5lPn5MQj5dc3HDZdmFCZ5EyY4puq2rvQOh6O1xZqlFXTTsAmroNN5aT+JmiIZr5SzCH/gb7wq4lfhcLQHJtpwZPAPYfsznmAYq+ozjyXeEqMNTPHbd8c+FuYF6vuZP0FuRnrRaF7Oyvt6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(55016003)(122000001)(110136005)(54906003)(7696005)(71200400001)(8936002)(8676002)(478600001)(52536014)(5660300002)(41300700001)(66946007)(4326008)(66556008)(76116006)(66476007)(316002)(66446008)(38100700002)(64756008)(186003)(83380400001)(9686003)(26005)(53546011)(6506007)(86362001)(33656002)(38070700005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mj/tnLRB5v4mwwTrwKKxZYzLcVa4NUkGjx0/SqSEGO+sqbH1nh6GSlBM49aX?=
 =?us-ascii?Q?GhiVWHMSZf/NKauAF18PrNgmXVgYSU5ySOBrCcnmE0hzGidqa1C/5hassAAI?=
 =?us-ascii?Q?FrNvJwXcV6dHOmvG38eBNJa/TMCTQVVpcEut/KLzAKPhZBjdbRrOihhXjvmn?=
 =?us-ascii?Q?ibicUQYxgpfmGYjGvfhrCQ9uMkwZh5XP06DogEzFkM/uBaMlHb4+WDgI+GHW?=
 =?us-ascii?Q?JusumtCu0qSBBsfJq3Q+w55EZRJC+P649mWJD56GPlse8oeIpyg84D9WBjqn?=
 =?us-ascii?Q?HQQ9wbg5Co59AxdHzhQX5f93UY+MHzrBGR590Fe17uvjYEQDQFy/tohPq95O?=
 =?us-ascii?Q?oIFinz1u6y3VVyvHa6fx9dx692nQDUSbD+xltdSvdDPIqZq11tcu14LRN026?=
 =?us-ascii?Q?tfpz/Xxu1nJL6ssGUf0Vy2HLkDM6S1Zrmkn2L5REZEu7aba4VMxBA0mfopxV?=
 =?us-ascii?Q?/6eQxvG2K3uf1XB8Vw/0LqELeyClmOoNI3hhx7rAJve58TxQqWUf59WsRD+x?=
 =?us-ascii?Q?ZmENUp9EzE63qElEABKx6RJLFFSdTyBZq9gxn6OKS0p1uHx6/3oQsYM8Eh2+?=
 =?us-ascii?Q?xPnEGwjL9RFZeSwkjx5c06S9+wRaEfeN1JnyLwbwiGJYawKey/XuWMfzPHy2?=
 =?us-ascii?Q?6ZeyDIXbeb+uOwdj7JFobx98rIR8zqYNVCSOEeR9TBVnEYcl7bWNOKs8+JiW?=
 =?us-ascii?Q?xWmRHDYWWwOA3v5ru6V9Z72yP8QsQ2BYrc8tqFS/uSP7Ol+5ESgAbJKl+akS?=
 =?us-ascii?Q?MEYRumamsonMj+POTB7L96K4+EF6QlxqKptWwi9EJOBxau13b7Yhk+N/qrte?=
 =?us-ascii?Q?c4CsYLgGQ9fhHZlGdDGq5GNmyS3wqEvzsZecr5A7iSTh1SI/OjHYvUZw0vtH?=
 =?us-ascii?Q?n1oxFKpz6fGBw4VILSWXAmlKg9Q0SwezWe45ZS1NFQixNGL53YBVf4gVcdV5?=
 =?us-ascii?Q?m+FvRrwB8GHo04NHXkR61z9odo+5whI2ekqOwtGB0Jq0KkPK9tW2uPQrWcFo?=
 =?us-ascii?Q?CIZavqI0OxILnxmRQskRqsI/JV0k27FWuhmlIV1U6I1coGzpr6kBk5w6feih?=
 =?us-ascii?Q?ZVdAnB+2z8KlYIe9z/mxQxEKeC7GCaQ/1ScxngqddoJb/iVuDdoq5SesEfjw?=
 =?us-ascii?Q?q4zGGR6fR18NQ20GP7myYcolm9xIUCoEi8xbZrJHM319/xU7rRuGN4Te+MC+?=
 =?us-ascii?Q?UbkWSJBmKs7xtWXljYFr7luEK/8E2OKYjkxDsMB+snKF4LVyG2fQN//yttGl?=
 =?us-ascii?Q?61PrgXJsJ0wQ+ReIlC4Q4ZITP7s2/v8bIF8cegiMIMt/xvGpt8IaYs3p+AmW?=
 =?us-ascii?Q?11/zkAQlbO2OIHC8FR2dfAeKkaJ/FpNRMe8OczFh2yaCL84Ice3ZD3GW8GKY?=
 =?us-ascii?Q?xlvRvtXpRM0FH8eLeyDWaqrhLTi3Ye8ygDtuNgAD5nGou7/j6vLjja8dCqzL?=
 =?us-ascii?Q?1AKxqlA5nQW8hdy9QjySv+mcFliKiEZnyAKMkRyU93+hzptLLpzlj9EUsy3v?=
 =?us-ascii?Q?3DoeEiiEz8p8syKRM3N2ZZ4uPMveFFAaBGn2nrjw/MZJk5TxyzYRFJHtRcut?=
 =?us-ascii?Q?j3rl/wLZ/cd+SxhVBC4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05abb12-bc40-4820-0903-08db88e4c080
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 05:47:06.6447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmgI/8UQobbUmGcOETultvpHSVD0e+/qZXq9lfGghZxB/nXKj3mmFp3fjV1xWmt3CNMlzFRKmtCI2b6v3p6cbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

OK, will do.


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, July 20, 2023 1:44 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang,=
 Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix incorrect vmhub index

[AMD Official Use Only - General]

Please apply the same change to gmc_v10_0_process_interrupt.

Might be better to check the client_id =3D=3D VMC to decide vmhub.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, July 20, 2023 13:42
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix incorrect vmhub index

Fix incorrect vmhub index.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index d04fc0f19a29..c0b588e5d6aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -97,10 +97,13 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_de=
vice *adev,
                                       struct amdgpu_irq_src *source,
                                       struct amdgpu_iv_entry *entry)  {
-       struct amdgpu_vmhub *hub =3D &adev->vmhub[entry->vmid_src];
+       struct amdgpu_vmhub *hub;
        uint32_t status =3D 0;
        u64 addr;

+       hub =3D entry->vmid_src ?
+         &adev->vmhub[AMDGPU_MMHUB0(0)] : &adev->vmhub[AMDGPU_GFXHUB(0)];
+
        addr =3D (u64)entry->src_data[0] << 12;
        addr |=3D ((u64)entry->src_data[1] & 0xf) << 44;

--
2.34.1


