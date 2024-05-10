Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC70C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 05:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E25410E0A6;
	Fri, 10 May 2024 05:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r18rciA3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A01910E0A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 05:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5DrMYsTCfLImk3PxJj/k8oaDvmnvMnfMlv/I5v+LBY2ESSldb/xsAJEZ8kjRWYtBrb7hzX48Xfwmn/uQO2gGo22cEklfqYyP6EK9oY8EanbA1KS3gvqveJPYeNg06p+QOuJWcQ9Hb7ozhsRELsfkuAwK40XvJBHXjQkNV/VLLVY+zHei0EQA6RtyD3g1apWfGKWOFKz9/2i+gvwTZ3Gl6TnNKfqIsa8IXHiLAsxUoByxXmLX84H4eUBLeICTtwKw+SApG9B3N2Y5BYXEFYX9p2RTQmSEo1E/navXKlCE6iDPCd+ddcx5vhtrUYxbDh9HwxajgsOwx9ydOvRdfVnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaGZDAulnAWoomai6A9pcIcE8QoXKUvFndtfCDYXU30=;
 b=TCCpTcFdTy9u9OZqWd34F3CkPRhZ6iThcpt3bMgF5GxxA8vJqhHUc8q2TAgd24kHXBJdWBP8GLH/Riy4Aq3vhgeDmj6Tz7q866zHdIGeb7qbolpZU5Xk8SmF0emnr24vGpliQv6eJ5+QzhK8FrYHBiryDK8oAsZkUHLQFZd+KoZPDiR19GXb59Vh+Zoszk6Y8X77IAVGzpkocCv/HAUiUeo7BUGKv5k/LJlhAjhz5creDYgUqhPBkJTZXn9ZCB1RN/EGqhjg4uMN2cGcxhRAAvG9itfNJb2VXpP2DeZ3MxQWjRD8O8dQHG3TdpIHrG9OWV13n5MiSYrfJqXxnJQp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaGZDAulnAWoomai6A9pcIcE8QoXKUvFndtfCDYXU30=;
 b=r18rciA3GHkcCcLpSTA5PRXen67dLR3DEgCcRUNypwFi3HDJOMGaXs3KG8i3jV0cXnzlTlYLLJFtOsYbaxZihdMTt03FnoL+vLfMFaRwrfmjj+WRlmWPeXQJkIZX0dCSUjb1wL0BILoa4+BUDHeGgSl93pu8Pjf4TMHwJethRxA=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 05:44:38 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 05:44:38 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 21/22] drm/amd/pm: fix get dpm level count for yello carp
Thread-Topic: [PATCH 21/22] drm/amd/pm: fix get dpm level count for yello carp
Thread-Index: AQHaooVrkHZnYZ8CYEmOQRF9m65fBLGP9NVA
Date: Fri, 10 May 2024 05:44:38 +0000
Message-ID: <CY5PR12MB63694E8A445CC8637A80CBA6C1E72@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-21-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-21-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=13f54447-b819-4501-a7ed-b9b5386874c0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:43:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MW6PR12MB8736:EE_
x-ms-office365-filtering-correlation-id: 54ba73f5-a37f-4eae-bd21-08dc70b447d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?CTv29TcV/zCsiRcqYzZSTTafUiqP7O4Z7ufE0U92OTJrnTXLKw67l6adieoX?=
 =?us-ascii?Q?9UzxocaMCouvtiCiObSjiLctbzwNjHML//hv4trhaTzQ3QWNrfdGl6O7G2Pl?=
 =?us-ascii?Q?Td/tUkxeq03IVQNkzoNpSZiYypjBrsCqfS3FuJleYIVXpUCRh8rNWSCvuxvk?=
 =?us-ascii?Q?IhmSPG5jrSSde6WMseIfy6fXSpxZE5CUFzAwv11u+0DtgSurbai9aht6uUQX?=
 =?us-ascii?Q?040SqP6NWPYWo/XvUvRk9MaqeuFBEH9seQSJsxbLYsLbqQPwxF/7YLiAN4p1?=
 =?us-ascii?Q?TAmimkEM35S9KM1KmCbvaGgls+c0O78hYFdhV3IiVXtHvjTINwuFtKqJ1w00?=
 =?us-ascii?Q?JVZKmCk6B0/D7Svjg1R3XfhSnFjv99HCOJNHPgmPRIL7MFwtMAFJn2yHAy92?=
 =?us-ascii?Q?PGKB+fSDOVYM6sXyCOCrmWVoSQGKOuzDg7xHjsCHUzS6UeILQjSTEceWBlVr?=
 =?us-ascii?Q?gvO6n+jVv8wZJKnmfx2/IfxG1Lishnw2o6dLT9FakfdY+nK/EQxrhXJYkgkU?=
 =?us-ascii?Q?6FGXA0TNMSNGJJ7IOjqtAGw76kPHk3OYZTBPVXWv9EZ4R0/+F7LHR9tpWXf3?=
 =?us-ascii?Q?TtI493eUngt3Flf1N1CtPZGV8VUQeOFiw98F+/FsI7ELdfNf/s3bw5WIzIsK?=
 =?us-ascii?Q?MRRajGnhKTT0XJZjH1Yyi4fldqYD0TtPd8qFn/1IItwGHXfqpZuvXX1GK+7A?=
 =?us-ascii?Q?UcdSBIcN3H1z4JVHaZz+2v/dT9sIofo4iyXevHlQcZts5X1f6lv57ff8J+Mb?=
 =?us-ascii?Q?YnVcqEWNDYuvGtnp90GjbYii9IIRBN7lFnVradKh5tzSlDcVRKnqXAtl+Ydp?=
 =?us-ascii?Q?v7jul8kwXPp1rooRI6pwxf+jCnJyuCI9jckvQYaaI2opBa6nci3qQzkJaa+f?=
 =?us-ascii?Q?y3bxyN+ipifJ0L6BJV3QbQUdgYKsZgkfdRMgvkb+LeDNY9sZ22P73hpqo2I7?=
 =?us-ascii?Q?wEnwlF0HcXamaKzfJ95dXv5gqYgLF6dcy+ouWyGTKvoUjYNWVFFc/iVDtAX8?=
 =?us-ascii?Q?siw547KrCB0cOo/bk9yG/cyvXiKW6fkmhBy0ATtI9gpLmvzihxiux0/eXiZH?=
 =?us-ascii?Q?AbDqEENkVQAzwDQIcW5ibKvtO3DIAxWqg3Aes2JwKLtZ0kRvqnbbZ0wWj92J?=
 =?us-ascii?Q?B5TeB5XPRncRNt0GXRk2g+p1WaRr8UkDmr67vE1eQcShSZicqwX4NyMPbYXg?=
 =?us-ascii?Q?1Rr8gOrmR1xE0Bo0xtyu73rpx5s4DWXpQnvEBzCm5WoWfEOHK1ZHZ8aRoAMW?=
 =?us-ascii?Q?4RZi2cxYE+h2Ev2tJTLeS89sORKZRvt8BJgZ+f+TMc1gfOkP5aEHlTbdL1Xw?=
 =?us-ascii?Q?I7uGkRSkT88WTkt4N2CRQ7Zvchz5b+uSQRrliRilyk3/QA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PpLlilJ2zkcEQJEEh7HR1pKv+iSgDGtH8L1WVpmSb4Z4eDvXVWkiOpCYcHs5?=
 =?us-ascii?Q?NHZOD9cPNUUWA5l4SrN/T8dIVYqVYln9i+aIHXfmsbEjdMZUw6BWuwMgVNXx?=
 =?us-ascii?Q?un1yfXkwCydPeqthnpCRLcPPC8dUfKDbTkt4O00YcLW0J67SnoOehLQBl/QF?=
 =?us-ascii?Q?VoAKsRbf6se2KZoaluX9gqQVZ0DBpAydMiV9jX1ET4xsFvRCAzQ53Di1PkoF?=
 =?us-ascii?Q?n7ewhE579h24r+sTB0jLORnwpqSwpvZRD5m7Gja0+jZpf18Xwr1abA5fAArr?=
 =?us-ascii?Q?YZO7Zch3uy22lWLr49jc5iIxK2RfGceVq048O1HvXYZQlxO/JEmb/3siMxLj?=
 =?us-ascii?Q?PHQSs5TFCY54dlmtnGnNKFVb0zeRJ1lI01mVJG/Yp4lQBZv3l3taBJw8LH1c?=
 =?us-ascii?Q?UC1Go956M8YW5WKoKpmlO3qXFyCXkpn/d+K3kvmy1JQU8/dqt05RmLYPUNo/?=
 =?us-ascii?Q?1SRoUbcdovl6YlrrieV2tyekXaf34bizg9C8sk5sGPq5efI4/8FCzMWKWoJp?=
 =?us-ascii?Q?Pey+fzslsrIQxHzM2teTs3ABry/fbRCcIaiuRdZqDcGdB51goh+YXI5mFIJk?=
 =?us-ascii?Q?eoUN9DntxYEWwxhU2w2trw8aQAlSB9ewSLMpqRcePOIGVzKnDhSxhXA0WLcr?=
 =?us-ascii?Q?IFpDS0nCxjMAS2hfIaArzDiv4OMoafRMZlwmQAafFfqlOBlS144M5oLrxoTt?=
 =?us-ascii?Q?q/pBNnfOZIek1exEoZSD7lQaWI2nLzO1Bdh3W/oflojDnIp7lCtKCLatbGCn?=
 =?us-ascii?Q?5QyD38+8a1WmaUsXebaTIEJnxtmIoCZV8PJb/luTh8Y2zDRdgjzlPOn2yQ3e?=
 =?us-ascii?Q?TutUF5j+TSwdp6Nabe5riL4tYYI/Z03tqr23gVja17ZkXkZGd+c6GQkj/zaG?=
 =?us-ascii?Q?BUNYADx28agYyu5kqherXXM1LuTPKkgGS4QNV3OjHrv+Xkt4Yv1JiVdm2/Gr?=
 =?us-ascii?Q?y9XgbiIUEvR3mcV/qpXCBN8xSm1rQ5rG7LgPFjN+FjziiJM8ZVr7NdvTiweY?=
 =?us-ascii?Q?4kBF/j8XhWvTYKCqIkA/+eLK2O2RQtKLZVFsIxcw6lFBCVhjFRIwTQ6h3g57?=
 =?us-ascii?Q?kMMxc56VtJGj4421bfZxxOUK/4eAfnMYS5WmvH5prBSnTCKmpjhp7aNEPgQv?=
 =?us-ascii?Q?q/tdXYv7m0QAYoP9N1HqBSY48rQa/cmTgymmPMwPbWFFZU2BGY4GDRzl2CRr?=
 =?us-ascii?Q?mTHgNnZyTVmZp6tlDfdqa/5bXC1Mtdv5sXhLP82/BOFoUsqoEeVKb2tm/Bn9?=
 =?us-ascii?Q?bSxDPo14yW06YvSPvLnLpr38OAXmdgwDZBeNSX1/7guuu4fnaTgUNqUgIN7i?=
 =?us-ascii?Q?cI1MGDyIvPBRFJu+rOKrI5hEGKb0S2Esa0ah6CyJW6YnGHHaAlScli5yXM0K?=
 =?us-ascii?Q?wcPCluZFCytA+tMF7NEPcLNYliQx2gIAogtG67+hJyAKq3SQAHhJL9qtX/HJ?=
 =?us-ascii?Q?dZT/Cn1UCQhaQjLV8oC16r0BYBnZodgjGGiIrmCLCbRbZFl6HHUi9EUv/6QH?=
 =?us-ascii?Q?cgfruuP6Tey9t3hX6EVJ3JK6jfwV1BhlFmeb6x1JM6D2m5Q737yotws0jA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ba73f5-a37f-4eae-bd21-08dc70b447d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 05:44:38.1210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GU+QQySJeA+salYYPadwzJp2d/vMcCMcfblWiYjW0oz04z6H96OepvzrNab0FT3x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Friday, May 10, 2024 10:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>
Subject: [PATCH 21/22] drm/amd/pm: fix get dpm level count for yello carp

For invalid clk types, return -EINVAL to check the return.

 Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 5917c88cc87d..260c339f89c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -777,7 +777,7 @@ static int yellow_carp_get_dpm_level_count(struct smu_c=
ontext *smu,
                *count =3D clk_table->NumDfPstatesEnabled;
                break;
        default:
-               break;
+               return -EINVAL;
        }

        return 0;
--
2.25.1

