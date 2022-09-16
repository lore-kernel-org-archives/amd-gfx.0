Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474DEC54EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 06:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EA110EC9D;
	Fri, 16 Sep 2022 06:05:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C494210E3B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 06:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JapTDHtro9r+YBr6zCx9UzukvMiif0kxABJWacrOLYiqDPUPXYz35Bar2LpZStbyXLxxE397ZDBc9Hs0id+XxLMJSImYAgzhMDC2fW1nmmqwrXpHsrF99I9mg0oiMUzdNFSSZM9a/IQufTrXLEAjhB0wYYYNX5b3TN8vn7pBIADMgWtqWlrEHAxWrkoGkd+QHaXe/iJyEY3LirTXilPNIViSUYAWCPSbM95i9vMHtoPwcfSykEYWoRmpZX2wVnyVUj28LEjFcDhdVqjHm/jmq3tP6EQC/8ih7VN9M+hPOXd7kJlUFj3TEm2vq8adIHXCwvOqjjhG8wQ4PiBqYme04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7G+Epo3YspSu1816deZovSJltfErTVNSsZErRs//cUw=;
 b=IjGqKc8GHRnN55yHeuXJYDSD7CXGyBhDFpHGTbxDvjelWQtxrLPA0KKCvit8XXE2euoZXbvrIkWPMHS3xQXngCRxgkpqxLWaDfCZEM9AIkZbWiJgUJILml+OCAe/Jyv8dOz8lbRh0YhSFc7UVHdTtmd11uO4CEbOld5xAMU2dFUkKPAgX/m90qcmDWptpzaoLZoTRDQKinI2i1bwPT3VH2i/S1/Uf6QeF90/gHskK5zLZKP3dJ43VehRuVhKMB0v9yBtWzOCLaEssPtwz+e9ZVbjVjn/Ma24yvqS4bluLkL28Lk4KrYyr7JwCdbTo9N7Odlgs6sSqgP8OAIMP2fuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G+Epo3YspSu1816deZovSJltfErTVNSsZErRs//cUw=;
 b=g4CZdXqyjG1Z1RvwHqYFPgHWJb4rU6xzeENd3HwgiFChDbzKnsHTB6eHT2RPjgjZWBib6WdzzEg045DUKQg2YTSdUjI0HmbqcrqYGt8dPLQfNp2atZ/97GVOgCqQEaRp3lWJktAKfJMZ2xT3sda1gRr3P0dZJdCWWZBw0JpSJao=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 06:04:57 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::3503:2933:a50f:7043]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::3503:2933:a50f:7043%4]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 06:04:57 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Gao, Likun" <Likun.Gao@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 0/4] support query rlcv/rlcp firmware version
Thread-Topic: [PATCH 0/4] support query rlcv/rlcp firmware version
Thread-Index: AQHYySS/9BwKkdZfv06kdeG2TFNoZ63hkiBQ
Date: Fri, 16 Sep 2022 06:04:57 +0000
Message-ID: <CH2PR12MB41521076D973F3A2F58F44FEFE489@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20220915170027.23010-1-Hawking.Zhang@amd.com>
In-Reply-To: <20220915170027.23010-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T06:04:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e2f73c21-93c9-4c45-abc4-630277389f8f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T06:04:53Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9a3bda00-377b-45b6-bdac-cabfe1cc911e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DM4PR12MB6471:EE_
x-ms-office365-filtering-correlation-id: 08e0e770-de4a-4785-7a3f-08da97a961b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUimyGJf0JaCH8D9/JroiH+DQ3/yZL3zlwWAkHgth2sts6OscleLRgEqzIYYrEAggkYQA00wgFvIK0H8tEltktSZEqrOQlEuYWmwGi5NHI+z9ld5oipcPqGVMZY8KjxbQA6S47JdQ1p+oEg6mbYEJLxBJTKzHpWTaTl3kmjYGpvi+XhI1uIYIXgBrPpvpMSxpfeAtUc4oetWI0B6rgqq6qH1lKpud33WgEjusddT+6UfNiKr5ml7utMINy4TmptV35/1lLMH/KXIUl0GfW6EK9ROG9Ar+Db3Z8R28m6t7ltXtpmdqP0EW1svpr6Ia6iliqxntqpzcEfAx0eLdzmcBAxzqpv8OMuVT+U+HJ0tUcTYrN5hlr24ENuZvp1ajU6sS5Hpmrk1OG2HrFGA7zJy8pJ8L1vu0Wdz27Ejwho3w30O/10TJhTiTWv+678F1GykMzIopUgejBHMHcAMmfZqWX5ketTIS4fQXKI36M0KVOMU9KqQanL/1wCUQRB2OltEyje0p79PYEMsBhClFgu0sozYvmcmopjtVSy+VIYJtR0qj8ZC0NHtdLR3MdZ59DOIg/3XaSpDZaZXl2XZ0J/BbPeAp9gL+IC0Y2yZzVcJLgaspDa1NDcD3c7JzxEXzwIYjjKw4OUcA8co3sEDPkM0VZZhiDcXDOYkp8Cy+XoQVOnf5SBtpnkB4k0i+15/pUvypGXjtcuPQtejIbDVtqepnzLusLISroDbNEin/2+0ukUf8Ip6gmnte7fv/O0/d42b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(66476007)(71200400001)(66446008)(41300700001)(316002)(66556008)(26005)(122000001)(110136005)(66946007)(4326008)(76116006)(33656002)(86362001)(5660300002)(4744005)(55016003)(8936002)(8676002)(2906002)(6506007)(478600001)(64756008)(38100700002)(186003)(83380400001)(52536014)(6636002)(38070700005)(7696005)(9686003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rS1SuBOr/S7vkH2MsHrppnYqMswav+ExsZmAt+D8U4o1WhQP4DGjxLA4uZfY?=
 =?us-ascii?Q?j73Cg31lM4QbyyA9DiCFHSt6xdosc1r2zqedOxwwaHd7vR21mydGCw5xf21X?=
 =?us-ascii?Q?xi9NpelbSwkhs1ZSWEcMlAqv/44bkEpq/pDhDteedXyWsoJS1VeHgO1TRgQZ?=
 =?us-ascii?Q?Y5GL8RvilCB9OqntzlbTKqyKlirWEfAwEzPyspFadFfgz8gUsxHN5VfdzWIY?=
 =?us-ascii?Q?a0hEoacajNPbjdkqwvmpcZwumxBb4bQ1xijSfnfTYiln2JW437gGAUTgr7eh?=
 =?us-ascii?Q?3M017W45NCLHJkUQ7MyZZqXDWaK6kYA8/NRdXmF8UNydo70Xie2v81sR3F4i?=
 =?us-ascii?Q?+RYVF08myn8gPbh0DWlJBZXhXaa6X4le0aMx6/w304Mr/CsHgmUPK6iZASpu?=
 =?us-ascii?Q?nAa0jxBlM1c2MtXX8a+lybxJhG+qNdTMVZ3ZF8zwAsKRo9phLnvgleMI8imU?=
 =?us-ascii?Q?jKo2N4PgR+dZngG9026VjhkaSftiQgpxPB+VDwFaL1+X72HaFYOghdDtCE2Z?=
 =?us-ascii?Q?dYiTb6OqnGQKupyYc5lKKuvmAiUtzTk8kYy4XbSjvp/stze6Ck2dZVCiw70t?=
 =?us-ascii?Q?9e5/+Ye8vGKpKyigCVJ2kzqTaRzTlVUDNduzgXFdbr4U4y/h/TFK/4+C+c5K?=
 =?us-ascii?Q?EC04G97T847fQF2VsfkFh64IlHw+ETTBrtknazmZQreoZqOys4Vm2heX42px?=
 =?us-ascii?Q?bJezXecEKFzM9KultxXNdxWZEgBExspnjEQkaQFYtgWGiI9s/OrQHTCg+NCP?=
 =?us-ascii?Q?CHsJ79cKk3zscP6zndD0oXptq+Vo+fdl45jSyqHb1qt5nqjrrh+pwWNfVGs4?=
 =?us-ascii?Q?CCXCSmexTT27Ag3ZW1xZtIz6kdvL+j3H1aj3ObLuemhNl1il3cb79tlG2jXE?=
 =?us-ascii?Q?iu+z0tjEPQFx0ioha/H7aGy7biDooBkzB4XMuumnfrMBNwnxF0QyuQ2Qp75D?=
 =?us-ascii?Q?6bOk9s3ba8VeSIsfWFeIevgDhzJlyU8sIlFiN3wtSO/j2Y7K6Tz2HKzqG/no?=
 =?us-ascii?Q?I4GBqSvntCbs4+aRyXyRti/Kou+TTBIZzgN9UXKx08P4udOt7daZPzmUEXJP?=
 =?us-ascii?Q?HpbSHQMOi2P6pIx806L5u9Le6IJQVBRRX4PYAhEyw6Ra3Ho8RxXiPoKTOpbA?=
 =?us-ascii?Q?aOS3uGTBBd/+3F75YZ9sqMAF14VvRLBAOa0Id0Py6h+XEKnPnPNYQOM5oOot?=
 =?us-ascii?Q?2cwp7ORo53sLZqUhsVUuBdCDwGMKHdLmH5HC2lt/cV7MJeZMn5m4Ed2pFHgb?=
 =?us-ascii?Q?E8vk3LG/3rmB3i8rWMskOg7w98YnRiv9L3X3uGxsZhV18JKTnXo7dPg9bIAC?=
 =?us-ascii?Q?y/6JBENt5U75XMelkyO8uPVBojd/AZnPL7Xk8bo3XlH43FMMMYILQPdLCVqs?=
 =?us-ascii?Q?34QJnb6hBlY25B3JKrIzlBfmEkBej5dW4KVLyOnR6d31uvNyX9erka8ejoOy?=
 =?us-ascii?Q?bsACkbyCA+va9wXFdX6qJ4o2fvVALYmoDW4m6D7pZtG9I/o5YJ98BWuJl5dW?=
 =?us-ascii?Q?uHi2u/gqy1mOo+BzJDitagXNYIruiHOEsYrTi7xO/H8+T4A0sYU3d8/+GuNU?=
 =?us-ascii?Q?OEuKhaIRf0KaafVWceM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e0e770-de4a-4785-7a3f-08da97a961b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 06:04:57.0846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQBKHtHWTJ/DlNlxPhm/E8PdxIGfOu/C+F30rvt6ADR+4pE6nWwDhssm1q6kKllj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Series is Reviewed-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Friday, September 16, 2022 1:00 AM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 0/4] support query rlcv/rlcp firmware version

To allow query rlcv/rlcp firmware verion info

Hawking Zhang (4):
  drm/amdgpu: save rlcv/rlcp ucode version in amdgpu_gfx
  drm/amdgpu: support print rlc v2_x ucode hdr
  drm/amdgpu: add two new subquery ids
  drm/amdgpu: add rlcv/rlcp version info to debugfs

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  24 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 168 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    |   5 +
 include/uapi/drm/amdgpu_drm.h             |   4 +
 6 files changed, 159 insertions(+), 50 deletions(-)

--=20
2.17.1
