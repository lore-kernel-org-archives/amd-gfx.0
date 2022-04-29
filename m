Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E59EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 02:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD3D10F6CE;
	Fri, 29 Apr 2022 02:46:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE3310F619
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 02:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFG9DjhuBazd4b7L/N5M2BM7oEYD/SUyucWfYNfjqwbDVJkXSY646E1Ks0wWKA++ELQXzroGDRy/MTcFqb1NMKBiFyuIUSRkbUa0lyIY36uEg0/CkqBEwCUA0qBMMeTN6sIQr9vwyotq6EAdk/0KI13UfEca0Doxm0/9W3kcjY+XMHhvsPPtSF5gOKH6MZGiP3NlefKC52bPcNrIAHrsqG2gmk3xwY3MMxVXc0t2KMhRn3C8hDUZL0Pj58+27+AANRAUPanifSie2cyduvYe8Fy498mhmHT4rbowPmXYu3NbYqnNOOrUrBRL0PcyDYx0HDd2WGq1O9u/bv5zdvqaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xna9/xPrt4gXgo1IEJRCgOeYuP2NpTuj0qyQY++h/wA=;
 b=b6xUqzLRlJWg+J7U/Sgw5CzQJ8lGrgscuyAg4uXJMbPn4iEaQhb14wDST+zULkgkEAb4bq+GIr/ma2l6zFFN3OyIau0/edfwH2pZKujRKuL02UddfcynYNpHIxNzrcXtxN5i1BaDnat2DtVksRsQ4PhN48HB04qwOS1M1gp5c0m3WprWI2SVc/5bpfcvKe1XMsBq+KtO/B6GHRjxYPHJ2EvEBQ1AnTSDcJijAroO4/0gynBGtXjch26VAz2KRqR+oPr1RTTQkm3HkGPXbh+3MUMc9aiRJqHH4ytFB5PQrmTof0x+nwR1b/8I8HGfQ/tQls0ydssUHi33O+R8scRxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xna9/xPrt4gXgo1IEJRCgOeYuP2NpTuj0qyQY++h/wA=;
 b=SAyoXR5uj2ncam6H+OoJTIOsfhuekl9OMfcGUmU5pcj9pPiyU0GJwEWSBWFg8MJLu6cSaGPMXPRY4HF4DwtuF6UBqCnesM2sE3VcO8CtcBrVQq+Ry3lbCHpRjVr8+NGNvdUcoX0B71y+brHJAEFBDbTf6pdoa2vEDR7ZMPUjF6E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 02:46:27 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 02:46:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sakhnovitch, Elena (Elen)" <Elena.Sakhnovitch@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Remove trailing space
Thread-Topic: [PATCH] Remove trailing space
Thread-Index: AQHYW1j2xuU7PIUqxkSDfLbct0utRa0GL9Xw
Date: Fri, 29 Apr 2022 02:46:27 +0000
Message-ID: <BN9PR12MB5257DCF88821423A017D1AA2FCFC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220428233712.1518398-1-elena.sakhnovitch@amd.com>
In-Reply-To: <20220428233712.1518398-1-elena.sakhnovitch@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a76976d8-43b6-4830-841c-965d6ff78852;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T02:46:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ddf3cd-0e2d-42cf-7013-08da298a74f4
x-ms-traffictypediagnostic: MN2PR12MB4504:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4504CB338A4D0EAFB0CD3670FCFC9@MN2PR12MB4504.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PQhjuX9WbKh1OPQEiWULB/HgNdE8hOQhQoap7R9BqZNzeEmtNAts73Ua9JhLIc2wY9UN2CfTYIQRZTaPrF8kfUr3EmaWETitM2mH7zWhKlYez10JkPE8BZLdqtItttnp/XitCdZ5rz83fPaIXUib02xAheRssuKCS9eE8LmW/UGOlFwy+ELZZjRg58eISpZpestNMEraG1/nzKF4XXCvurx923nNW0uVGKRvhwcjt+J07EZaqWWvwMa/Ld+Ig2Z7iyj3FxD5A06A237xB1HaXMxk0fxp/isC72M1qucUkXFZ0Elw2iq3FBYraFngmm5I+9SXr9xxRp++5iFhTxRqHhf1cao2UZ6DUe5x5Nr8+pv1vN+pCQ6MIJaKnW7BLUT7OxFQPQ+XmLp693jjLbAAHyvRoc5JotlpzkX2mwSqtBYSjFK88oy46hD4F1obfdiCA9e516QHAaTQ9fq4+ilrdamdAMc6vCKr0LE78DH2mWpru07ayFTO1KQCXWVS3nDntVHFvB47LWHZZiRbjy5TFZLKbZCQI1GDMcmqlzR1wLCWOl9C7yLQMzy+al/q8dD69AttyjanOJTIsL7+wd6XbaQM1EQ2GoArY7D0QhgNKs9mH82qvw7ch752jIQj3KfCHdcwX2Chx+lG2QD4oEkcag0RLcPID8UrMqPxOCuGUXfx4xg9eZGLdNnkfoJ5VozjfZKL/9i6W/Usn+S3VGyPpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(66946007)(8676002)(76116006)(66476007)(4326008)(66556008)(64756008)(66446008)(5660300002)(508600001)(52536014)(8936002)(2906002)(55016003)(83380400001)(33656002)(38070700005)(38100700002)(86362001)(316002)(9686003)(7696005)(26005)(71200400001)(110136005)(122000001)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IVmRcmxtrtYVOkcql4fi4Z5ZJH6kwBBB61HabaHpd5sm706s58IGX5Q3p2Z0?=
 =?us-ascii?Q?FKQcEkUIymI8CR+wM8BP2jW1TsrWwl3lHIHZ5if78bdg4BZtrgMMyUhQJxt8?=
 =?us-ascii?Q?kK5outF9xxNvdYeIhBXUI/f8o0YJsj0dhQ36r7TJPehVMiVjW3tnVtqqqCW1?=
 =?us-ascii?Q?2TFGZvUhy+Aj5oPbLhEU7QXdh8gB6EaCzqzInQMsTzDAZmZR+eB9Xir13bAe?=
 =?us-ascii?Q?OjaUlF59U187XWltgLI5VCJ9NP2wyf805H223AYHTYi8cmoPtcx8xGgAXUk8?=
 =?us-ascii?Q?alxiqgc9yzZVraRUc9pjWSnNf1AOogQp3kHSjQMW+OjfCLatbjxUDXXrpJiL?=
 =?us-ascii?Q?/+NN7W+o+juJf6AHuN3pywK6CrnaaXBq4+1uroIyvYhxwNsVBWlZEyqFEMgr?=
 =?us-ascii?Q?KAC7kOLHyooAC6hBiS9sKc+KBCws93jDzLhNwPny0H/57TdDqZ0GIbyEXSmR?=
 =?us-ascii?Q?RTZxOW4wxluEG9U17cyzuI/8fLUqyOYGurNqlViRMvXhUGmFgkM0Lmjkfsj3?=
 =?us-ascii?Q?LsOSwA24iAaTQeeFgZPk8GD0yBi+sko0Di2Jn6wiyzHEmuJe3ZBrpfjP5xUz?=
 =?us-ascii?Q?gZW8FCgIvku4fxSkehvDgw4146eYI43ghIz8T0Sw9ji4mlfA8roGz6V+twVc?=
 =?us-ascii?Q?7pyj9xbFv4ukxT6mZtxJMpGn/npI5ChwA89aG39P/Je9jMRHkr9P0pjYuagf?=
 =?us-ascii?Q?EFaoylhuacQ4yj8awz56fPKyIrOzfUkyu1kHCOJb5YvtJBPSpOnIDn98CJ//?=
 =?us-ascii?Q?5GXhIi3vtolxbTeUE/qS+PGiD0+sB3okj/ophJNauz1eAsjZKxRJUsHfwbfb?=
 =?us-ascii?Q?BUio3Hzw7J0fIiApyfLw91lupy8SrDtu3++Ek21KHHuYurLPgtey8RtYqWlo?=
 =?us-ascii?Q?JmdfKOhpp2mWT5XwLo6JQ+ruEJS6o6CkMeEVEykjDywwGccXs9CI1LAf2jqS?=
 =?us-ascii?Q?g4+4uS8rlE76DByEdKU6dOSNzyfYp9M9SytrfyhR67Uauk/yetGJuSdGHT+B?=
 =?us-ascii?Q?cpwAHlg6/WpadkEAx+ilXduEwJ4oc161ike8fJHzIIP//n2uu3xDCPFe7e6V?=
 =?us-ascii?Q?PJUY/6ISI95S6vHIH6QeoMXQZq2HIt8AGAL9XoSCgXm+p5ochnYTEd7QENcA?=
 =?us-ascii?Q?gI1tjbMYsgHn8BgGumD85AHQgT1/8fyU+0Iimp94wV2eK0D28vrI/xsyf0nG?=
 =?us-ascii?Q?IOxKSVRnO4yHwVPyJIztw+iUP0oG0I3vWG2pCL3CpifhdEhVkfiALnmmC706?=
 =?us-ascii?Q?VgNfRmSmm6xFth+ZxfmLLSPEVee3Q9A93VvL91heRoxPCOVZdqwNXsYL4rHC?=
 =?us-ascii?Q?c0dQprFe9Xy1dpnrWWeiT9+nvYqBAmHc3XW9BAfWMMI6zpaSi933WSvo2qoJ?=
 =?us-ascii?Q?E7kUxNUyhFddKS3hNKuGjE2kW5kV9xJsyllSXm2FU6Yvs2gjc1wy5UZKEL2q?=
 =?us-ascii?Q?Vy3RJTt2ZL6i/u+fc+YzTcMpMNrrilNQKrPr83pvOUpuwLMkYo8XIjVf+h2f?=
 =?us-ascii?Q?Y9iW7XhXf1dcbAwnStMppqiD7xNpIHGFZxOmCernwIDT7Kj3YMxdk5jqey/q?=
 =?us-ascii?Q?umWSsZI3PD1DVXgz+so0EVgvHYubblhG87v4QDSsxVa26pmdvIjB1NQ+ADZO?=
 =?us-ascii?Q?24V2YJKXD/LFUiWK6ZDGA80pwQMnrKvkqqmcnEFbaGNfkmFw8+zI4Cqxvc73?=
 =?us-ascii?Q?565k7TC/1srBO2kcPaiE+eiTEGGHZguOe0xgZqe9SfhwCyJ/UlPMpTjPaPD9?=
 =?us-ascii?Q?/X8c2079SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ddf3cd-0e2d-42cf-7013-08da298a74f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 02:46:27.0436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rT3u+SuGImBFrXjaQb/85rCG8x04CZ9vWB9C9/vEJ5Pp/QAz1Z2xGB8/0Ge6UceIONz4nQu1vHVMFYDHd0q/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
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
Cc: "Sakhnovitch, Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Elena Sa=
khnovitch
Sent: Friday, April 29, 2022 07:37
To: amd-gfx@lists.freedesktop.org
Cc: Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: [PATCH] Remove trailing space

Clean up trailing space in file sienna_cichlis_ppt.c.

Signed-off-by: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index ab3e9d8b831e..e4b254775d00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -410,7 +410,7 @@ static int sienna_cichlid_append_powerplay_table(struct=
 smu_context *smu)
        GET_PPTABLE_MEMBER(I2cControllers, &table_member);
        memcpy(table_member, smc_dpm_table->I2cControllers,
                        sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->tabl=
e_header));
-
+
        return 0;
 }

--
2.25.1

