Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A6606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BOPF2PHF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2946210E420;
	Thu,  5 Nov 2026 03:23:08 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B5C10E0A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeYm3nKXiXCIDzgeSala4VJngaP7vWVXT4prVqtF1pH2PAweMK7Lrxhf9JmZ4+m74uDBTgN1SSbwI1t/coCI03XT70YNJStgmm56OO2IIddakZIzs/P+gcoQeSf5QpO+03zDF4sQ+dksFSlWrX3TWm5pAMPZQWEYa9YgPpFXu1HYDWRBd7i/mWzgtugYbvFRejcGgsoyL1PJD41Dmsb5U8t7fzD72HJxu4YjOiJ+o1BXxDtXDj+lQFa10VXNRSmhGYajL4mNBE2i0XJLygIeUolkc+KI8eNJhz5r2SXxZ82hcwG1vEc+NVEc6GvWtT6XxKBF/x/yIMZ6ge2L1caViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0eIo+tCFa0JMTh58Uhf0ZirQ913U1BjwyfWY9IeO5w=;
 b=nDPBFvwldyOWrtTyXfiD+y6fr7nFQB8Hi8Y6JLit3eK9NFN34zFByhS35QxQ4REf3OaTLsnjh1gz/yur+0iinzNfiyJ1lpkt393chlniAWnL/7I/TElHFX1O3YeejXnMsl0qSKRIN3uZGpZoohsrn1DC1em/v8mNOueyJELK+2PCkSuIKCPpSELVlHhiWXNS+8yhNA6yYQLMp37nHoPnDtfn/7dLf4EQxvAHZWrMxERkkj45F846pvznNAoTor2FhrvVz+/Jsg8GUZ+5Zq2HYkTYS8/Ll8EeoTS0/VJLRzeKjiijcoPOZNE8bMCUIfHpMQwJoThztNRu1aV+oyRK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0eIo+tCFa0JMTh58Uhf0ZirQ913U1BjwyfWY9IeO5w=;
 b=BOPF2PHFuSypgQ3zFfvNZaxgCFij9T7AwXzvRyKQHPK6f53TLuXNezMEFGq3QpnDG9lVITAcx1m1C1vDfpppGfOwR/qH5ZA+O9nYHCOvnwYCV0Q3VEHhxjt8exQ99BkF5CbyIpKPwUpEAmu1x0Pd05S9qdagCpR0YEzkPHxh2pk=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 03:22:57 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 03:22:57 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdkfd: check CRIU SVM priv data bounds before
 allocating
Thread-Topic: [PATCH] drm/amdkfd: check CRIU SVM priv data bounds before
 allocating
Thread-Index: AQHdapgsQAoiLEO2HkaW9PjmlDLhsrce1DeQ
Date: Thu, 5 Nov 2026 03:22:57 +0000
Message-ID: <CY5PR12MB6369F84397F79AF295E20006C1772@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20261102070227.2217976-1-perry.yuan@amd.com>
In-Reply-To: <20261102070227.2217976-1-perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-05T03:22:38.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BY5PR12MB4180:EE_
x-ms-office365-filtering-correlation-id: 363fc1a2-85fc-40e4-e37f-08df3aec1683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|261102123227099003|22082099003|18002099003|38070700021|56012099006|11063799006|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003;
x-microsoft-antispam-message-info: mWSJxesnUeDGpxS1hd+vH99WhO1Qsp6eX0MJ1Ph2GrII/42dELoYGoKiWMQULB2Sp9PaR9ADSg90yFSegHbg3e/sWi6w/9R8z2bqS2a0Px6rm6wfu2bDO5meru+nRuPi4QQubiwII2fV3VXKZeGNxTduT5WmMewQq0xM/ulBNCbhI2qof/jFd055NV2GS/4ioCoQqKMs3s6fyKy3D41TTKQCSdwATSIz5BFKTX/I9trgZElXuxO2CraQnSbjh3xyAGrVyF0Hs7mPWiGJM+H/4zsjy/3+OKlWucR1kL8edG+OhTE0Ue6KNo5ovQ01R/+p1akIjFjQkjDOvM/a6TqAyIWeXyTLiyPRbSFGR7MAnJTh2pmrU2fIZULwlcbVASf+mFZKUF/UGUm9Xon/6BVOkPwysURHMDBhDSbRXB9fClSqQtkOxPk5RBfZMSED89wGe3sX19P9ijrOqmKcrOg22D+rd23iqOFgrzyn5Zt5lp3Vn8wZvSbvZRkSIVSZJRUc/KpGdpj7kXCqs5JZy13OVBlM5ikwEYMhecpJOezUQtDDHRMF+8PNLRwMX1YU/j3/Nd3h6Xtis7jOeZUwhnK6tNLDEjY+S5KvQIHVcZr54+L2/3/Q1STk+oCzjIuWWOGS1t2ULq4hpi+rJ0waFFpbcyjFkhvRf08nnUti4hfaiY8fnStMC6Ea4wp0FvdLnrIp1u6njdGhKDmBGyfuEnbPitAVAC2WPOugqLqGKTzoT+o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(261102123227099003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KQFP04xG0vgYhTa/6koTdgv4uMQd1MLM4YCqOzN8opXLSTGmlNGCOn0UgifA?=
 =?us-ascii?Q?dFnrcSSOsWT0tRoKgmeXiqcTdtUwR7GwbHNjLm4E1yw5EYrXMsNXsX7fsIue?=
 =?us-ascii?Q?fOSnfa4YJMl8vfu9kf2xGfA3XwxVDr2WRtP/GsvdyTVNBvijYsl8Fwu4SpEB?=
 =?us-ascii?Q?RARh+4r+qLNWvlZ0ppEh6Z7d4Ocxd6YbbfVNKHAv1WrYPL643RHaEDb/gfxA?=
 =?us-ascii?Q?zY08tyRlCeAH4xuPUMv9RlnqIlBwh5Mu/4jytbLidxu8JnOoSCP3x/ztOLMe?=
 =?us-ascii?Q?vgAUuo7MZYpaceV8NpntFWVXVuscaNhC0/rI6G9DPFYHK9dayL+WeomSgCSs?=
 =?us-ascii?Q?ZP2XtP+LPnFj8w1mKdhfIhP6mD0VYve/rcKP1Ed1RsTXFkQ3MLLaAZ2gTwQ6?=
 =?us-ascii?Q?1YjQDUcqbTa6dLVgvDnuOnZH2JiUKmb9u0Txewo+ZPLdx6a9LBGd5pUDEbBI?=
 =?us-ascii?Q?WUkq1RksGxzuWt5ficH3L/RBNrfLdrTXXVah5agMJTmw97EhGRTECSwA6l+A?=
 =?us-ascii?Q?57L6RSw54qU2AtJsqR/9nxxQgdokviI/uEh8vMCrBVLCfgeEBdPYGy2s1Xoo?=
 =?us-ascii?Q?lOe/3hDAOJi3n2UwuexvEWRT9de0jD8yEGMocBnYWevCsUkEN5IEMymR4BwW?=
 =?us-ascii?Q?yAGiC8TXhFlpzF2ng0mSojT00RJo6E8Zzbn37zmrwgeQB7PSHIWCfIJ1YgrU?=
 =?us-ascii?Q?u5/NCP0JhVtCvtBWoXSzNLTtfFgly2m4jyiM04/F1tqpq/qr3EJQFzP9J7sl?=
 =?us-ascii?Q?ORwKq4mXGuyt5GxTtpUaJXRI4zJSWTKyrNUxknqclI9FSCuugGwuJcoi0vsh?=
 =?us-ascii?Q?5xIloA6xeH/5tQcJNWYY72FNLZXsX2ALRLEd1bHm7B5HOKWjDNNwaBoQS3Ld?=
 =?us-ascii?Q?Tqocd4fkrCuw9S+3PRv28xabz8PgC+pET6uNqr+K1ii6m6wGS+y8CL/fp2lo?=
 =?us-ascii?Q?4Z0oEeIAh9QoVhBbdF0YFhGsZI5CuTMPtzYW8aUvCUxV+HK2M8ykW6ti+MlA?=
 =?us-ascii?Q?1rF9yOQgE6rH5PHtBmtUm5yTXJVT4ZlfFCwySGhXKNly7LGnTGUWJno699tT?=
 =?us-ascii?Q?eYvNV6Y63TK8p0MQgfsmIfnkGPHTfqbxiItCPzMXAX5+BN02ymDHpALp/lG0?=
 =?us-ascii?Q?XxSkqq8PsTOK4loFMkJS9mmlAbO+r9DLguHcdPle9DOWHzyvgYG9X/pRd73e?=
 =?us-ascii?Q?UnQ5sloTAWI9jjIe1RNGFBNs03YbWwB5bUtKQQ8mEUsAptjyVERtCW8lchYk?=
 =?us-ascii?Q?SR7J5JzdIXEuXxOk3+i3lXqnrTxnzLbVgah9FFePNjsOnNs9lqLqFdJBUY7E?=
 =?us-ascii?Q?wXmkBtg0tmN3YCtQYLz0NiBT06JcNiP/keae/iIOTWvj/21jb7RV92ahmVlm?=
 =?us-ascii?Q?GQXiqpZl9bx97QRdPdK/wQVSLjkbKhZD+vjtgWElgog9Nb9aqUb1cpznEVVQ?=
 =?us-ascii?Q?0LIZI/J7Uhqj27HVVTUkFNZUbisPj6sPurY/NNeGkjAFdxzuSl+1VAFCM9Yy?=
 =?us-ascii?Q?CZ4u0Fmme7iLF6xGDb2pWL7z7cE3UQqNZWsEfEMW0xWYsu0A/hmvhYcp24rQ?=
 =?us-ascii?Q?oj8t1aRkuGKXPT34Sg+IIaSt5XUT2cvKJZoVy2TnRZfsJSAXJE66fsw8bZWA?=
 =?us-ascii?Q?zjU0lpRHhwSfea0dRlQEumuK/HCED4WMPyotkKB8cXviQAoaDVC7votlcppi?=
 =?us-ascii?Q?vmuVfrppFIdSOy94K/Pgyy4iMx4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363fc1a2-85fc-40e4-e37f-08df3aec1683
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 03:22:57.3097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBP4JnUH9axaen1mZXsGcwrSmfGvvi84TOWLfDS9IxTb+ET9o7x446q6/Np5XQte
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

It looks like this patch contains two separate fixes. Could you split them =
into two patches?

Best Regards,
Yifan

-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Monday, November 2, 2026 3:02 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Yuan, Perry <Perry.Yuan@a=
md.com>
Subject: [PATCH] drm/amdkfd: check CRIU SVM priv data bounds before allocat=
ing

kfd_criu_restore_svm() allocated the per-range metadata before checking tha=
t the range fits in the user supplied private data buffer, so an out of ran=
ge offset cost a pointless kzalloc()/kfree() round trip. Do the bounds chec=
k first and return -EINVAL directly.

copy_from_user() returns the number of bytes not copied, not an errno.
Test it directly instead of storing it in ret, so ret only ever holds an er=
ror code.

No functional change for valid input.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 3023b0159ba5..b9bf369a9fe3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -4236,19 +4236,17 @@ int kfd_criu_restore_svm(struct kfd_process *p,
        svm_priv_data_size =3D sizeof(struct kfd_criu_svm_range_priv_data) =
+
                                                                svm_attrs_s=
ize;

+       if (*priv_data_offset + svm_priv_data_size > max_priv_data_size)
+               return -EINVAL;
+
        criu_svm_md =3D kzalloc(svm_object_md_size, GFP_KERNEL);
        if (!criu_svm_md) {
                pr_err("failed to allocate memory to store svm metadata\n")=
;
                return -ENOMEM;
        }
-       if (*priv_data_offset + svm_priv_data_size > max_priv_data_size) {
-               ret =3D -EINVAL;
-               goto exit;
-       }

-       ret =3D copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_da=
ta_offset,
-                            svm_priv_data_size);
-       if (ret) {
+       if (copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_data_o=
ffset,
+                          svm_priv_data_size)) {
                ret =3D -EFAULT;
                goto exit;
        }
--
2.34.1

