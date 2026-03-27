Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF510F2865
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 18:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CF410ECF4;
	Fri, 27 Mar 2026 18:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zZIN7ZPh";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6651D10ECF4
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 18:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Icrb9ZMqvzUbKS44+Sdx7xwI864tkLPLuJ+OEs+cNV6wlw8eK9lZNXpKdxUQRUNb3CUM6dMCzKUVyZ9tI453gC86lFFa/uNlsouvww4gbcwcne1aWTobDBoAGkYnYpWcKlB/YhiFPOz8f5Stj6MpPvX2xZFrszGtQzimAeDDdhQHF9lPtfaJjM6CT17F0re1YJ+XQTqrfTM1iPqCQTy3ipZ5SPBhRKvK7twnj4X35hTsQyf8POmmx8UQfRYSqKM4gd7CB6cGGOR2X0rtKCzNTDfPwYwZv+ijtAS9SOiZl5V6S3JCyHiYSslcsJnoW6MMCDJPgKXedeZuV6RohoDd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0dKp4eNcMjUWPgDIhFbrjp2Bnf0RL3VaTnMHi5weEs=;
 b=NanWEaOIg6xXm9C8Ra82aIXSQ7KUeybSDutM+NKJO73e+qyyQiIzqBFBVFuH7bNm4pqb28FuSZtWeECi6j+NfSNmkklbqX52f5iLGIBIEeVXQeHDGucVnBKj+ifRi4VIMsdj+odq+MV1xjgAV2zC8tAgmcDWNdXiHpBdLI/R+ApyItbEe+YyadI9mp30QogF7YSF2iKWgB/gJkfu+hbBCSMcKrKG1f6dyehfgN/g+0gFdEYXlZX/WmyB7tPyyEmB/fexFXer4Zre/JcTR+Cc0FOqKRKionydR3gmpUlSFwz+/Co1HrAs8UDH9+cM/88g/6g0FQcoNVaeP41Ffxe+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0dKp4eNcMjUWPgDIhFbrjp2Bnf0RL3VaTnMHi5weEs=;
 b=zZIN7ZPhO13ysQiMLDCXQJh5sgpAI3lHx3t1JMnRZcKnnZqYYfvHDezsuBaSvrX3ja2SkEaHu+G9nCBzjcsZFbdmWL1snovSFmQHuM3T3r08l42n6FHrmzdAdaLIxA9nXx8b5Xr0VtU2FO+LrtaE7jUc1e14BWmBW0Bfg0REiYk=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:18:57 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:18:57 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix kernel crash on releasing NULL sysfs entry
Thread-Topic: [PATCH] drm/amdkfd: fix kernel crash on releasing NULL sysfs
 entry
Thread-Index: AQHcvhOsfk9qGRF8Lky+nw9rbmX5rbXCsB0A
Date: Fri, 27 Mar 2026 18:18:57 +0000
Message-ID: <BL1PR12MB5898AAF3216C75196494543A8557A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260327180036.131096-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260327180036.131096-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-27T18:18:48.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS0PR12MB8562:EE_
x-ms-office365-filtering-correlation-id: d52b2e99-5d55-4dad-3314-08de8c2d4fed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: INXybBs2Zot88UngEUFXLEYo6bKqQJxig2y4u1uKcnsOczoz8qcnN82Ff1lALIHSl0YonRCulsZw3WxFwdjhjFqkc9guNrsPdlfG/arP5cj7JXl3wtKYZH9BX7DZxxRcWh+gZoLa9ywtiH5DuCSQYisUArzC9UiqAtdIWpDJI7C6K/OMt+suQXxc/MeYC81ASi4wBkaiGtifG5QPZCB4lLcRc9F0XzU6zEHQqIbYnXZASKDnRA/pY//PqpxkxYsJd+WCFlQ0V9PPMRhpPaTyzIkUn0II63Eh8ABp3lY+l4lEcMiKCUzH3m1BuoTKTb2Twz0kHr9gSmXyISz1fARGAzKw/t+htUYJ8RnEoYNfo252jayRDFYMXcXqIxS+1JiUDJUGWmKUNvtYORYTN+kZbJoc84x4zL/bbARS0OKBl6qieQDMQo//msA5iLpdrcSoL7KZecbA5mT0vcwY+srHof9lrk0bJa2/ttkgzs85NcY22yBD1HYCac+qJB0iW5Wcgep2ruiLozy4RGRtBQNBVIiytSCfbD+9KHjhBDIKQP2cjD2yxzreGFPMFplIfwHzRpYnFvC5FlfN5v6mXIAkz4Dm0JusyhO/P3rCaJ/dOqlqlbgMUsiuGPsaFYvKmBKVgRBcmC4esb5CjwNrqHfPAdMP7JGyhimRSaQvMUUVM/P8C+YVTFwLObr9Abf3tnJavrN4nemrmPgMT8POZcNEEZ+8kp6NVQ110p/fCI+7JVQihEZTxibjpLc9bbscP/PfIchiCeB4EotM3943aQKvZ6LbInLHo7DxHuTUpJz1GkE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BjL3ptw6jQWV2N4ODB1P+Ol3wguxIoVkMR6mVTZOMtJhJXIeX8wOWyE2EPKz?=
 =?us-ascii?Q?D7MK9HJgGXGz29JaM8K26LXrJHZTV0Db7CTV1+zP0FSMA6zl8NY9mz3MOILU?=
 =?us-ascii?Q?Re8DoZMD3dgWpKZ+2EuZdHaJu9GgwSF7nBaB/4K9P9u+ziJ/8pEg6X9O1BGi?=
 =?us-ascii?Q?RAspgvJd/RcUERT7uS1qWB8CXEDP6mhzFueFp+9bDzTbw4qq5x1M/eSWDD63?=
 =?us-ascii?Q?PqZtm3Un1Nag7A7e7xns1FLRquoEX9AJRvzTa3bc3sC5rDrJAaXkbAOxyNUH?=
 =?us-ascii?Q?EiaGuUwoGRH/0roviH9jUnKEDm7n28NI7cas1qb2u/5TmlqjVytCaZ78gIY0?=
 =?us-ascii?Q?I4YpZDB+12mOiAQF5K8zjx9a+fErMlT6pOCtdCIK6/PvNIPEn40wLxjyr1ON?=
 =?us-ascii?Q?urpOnSpF88up3EuDU4I9nN6tMC9gWQJI2X3wCVdJvokaIhC+30j1bc2MDiER?=
 =?us-ascii?Q?mQqN/5+YxCcTgQWOrF+/sB/FNEBxGew1ThW0Yjnu7rZru/jg7NzG9ISKYzU9?=
 =?us-ascii?Q?Jp2Z76AX0eV2QSQ7s3oiFDHq5EnBOPpcQQxQ85+38zJPiIia1iwB0rCWab8q?=
 =?us-ascii?Q?ixBKWUz38ft51AqTkZegx9R31vrKuD2CNMbSrPA5ro8NIilBt/++859+hpHf?=
 =?us-ascii?Q?Sm5l/qFVrjo1XtNj8YgWlDb5LVftre8umVuwQtmXjCDV8rAcxX+48vliisBD?=
 =?us-ascii?Q?wLThQtNuDMP5lv6aM1HUcEUE3GDpIIIm97tJ7qP2q5cxkkFO7ZWrZtbvj9s0?=
 =?us-ascii?Q?sPFLehchU8HkZKgBLi4K1DWMTBfw4EwClb6luroG2L+mKMRV3OpJLWy0bRij?=
 =?us-ascii?Q?BlO81rx6Jg2Yx5boimoMWksnSnWMChSbYd8cOFnGgoJLxVedh/U4ppQmMbY8?=
 =?us-ascii?Q?ht7IRHXpcqqSqMJzZaID/5dwNOQ2vFFwGlGp9ix2qmflMLYEtg9M+rmeLbw5?=
 =?us-ascii?Q?iMeSU4ziSRndbQJzE2iQMlw/tX+/ODHrLh6fkZ72j9NjT1qzSG9iq1hKe8F5?=
 =?us-ascii?Q?CSsUDTu1l1ftyaJljyMM8seQh3nEgApU68RD5YHYffcgSJ0ba7A065Sp9sin?=
 =?us-ascii?Q?/E47tfxk/fL7EuXAyu2v+xnAUj8O44K5qyoLd15DV/Klg9LuddFxcOZ5PSWf?=
 =?us-ascii?Q?s/jKa7hlM4fQZIdAMfVAqGeA21xaLK8Oj0FD6qXYZUaTrEknZIb+C+t0kLYx?=
 =?us-ascii?Q?hrtO6iFBs+OP7hL0Nv3lGXqljTCpzxzV5Llmu8KSLxA/srFPs66E96GpKpa9?=
 =?us-ascii?Q?/gLT9JZjDJZHM5edarAXtg5ySzwRtHgfiHPz6/yyZYP3wYB2rem2dd8FBxF7?=
 =?us-ascii?Q?JoPFRGt44/AOIsjaZ3FTiR7DAEMR4fi2MdKAsm41bkCw/I/tSZVA8T1F87PH?=
 =?us-ascii?Q?Qv+O+wj9ysnA2Cw7BPYYiAB6QfWlLJaRdWmRdEF58X0oh3K2c65xAtrJsyBn?=
 =?us-ascii?Q?cHcEbTLJrldZSEq+B2zri2rkoqnEvbEhMird41yIDPXp9yKX7EjLWbfRuDjp?=
 =?us-ascii?Q?wJWABfvabHjJ2PkOQKVc+od6QYy6nyKIHJ1jUM2HfUGNyNyS5n5Vie2W/c9f?=
 =?us-ascii?Q?CwPMJT6ZvkeQ/PdCWqX1tYKzyFoNRBD2S368X6VoDnY4RKlOUHA835GppxON?=
 =?us-ascii?Q?E0C4kRcD3Hmq95WYWWbfls4I3iDhz1d5PrPsyPDlFb80LmStDjcoTdBhlBYi?=
 =?us-ascii?Q?Zf3P4YQH2KjUk/kc7I32Y015DvxdU6PlpWkEkjuIucwgZ37y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52b2e99-5d55-4dad-3314-08de8c2d4fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 18:18:57.5036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRNk2BwQszyZECiZsmNK7FS8LiS93eukHmBrHMNMFuA0+sDUJWkgncg0ob/OPaP1YV+yzyeVpMfdtboLPZlDGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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

[Public]

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric H=
uang
> Sent: Friday, March 27, 2026 2:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH] drm/amdkfd: fix kernel crash on releasing NULL sysfs ent=
ry
>
> there is an abnormal case that When a process re-opens kfd
> with different mm_struct(execve() called by user), the
> allocated p->kobj will be freed, but missed setting it to NULL,
> that will cause sysfs/kernel crash with NULL pointers in p->kobj
> on kfd_process_remove_sysfs() when releasing process, and the
> similar error on kfd_procfs_del_queue() as well.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 8df76c24b394..4333a9623a14 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -679,7 +679,7 @@ static void kfd_procfs_add_sysfs_files(struct kfd_pro=
cess
> *p)
>
>  void kfd_procfs_del_queue(struct queue *q)
>  {
> -     if (!q)
> +     if (!q || !q->process->kobj)
>               return;
>
>       kobject_del(&q->kobj);
> @@ -858,6 +858,7 @@ int kfd_create_process_sysfs(struct kfd_process *proc=
ess)
>       if (ret) {
>               pr_warn("Creating procfs pid directory failed");
>               kobject_put(process->kobj);
> +             process->kobj =3D NULL;
>               return ret;
>       }
>
> --
> 2.34.1

