Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A9ECCD183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 06:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195B910E931;
	Thu, 16 Oct 2025 06:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2u9PcdR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569D010E931
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 06:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkPlTlwtRQSaE6u6VQhZr6YegYNkKk567zIaxgfnLGjnNWxe+PV4opFwaejpVSAqxUVwAb+wNmDY/Pz/gs14jvZ2gKMP0jfU0i2/Ayvd8M0rtoI59hU1s93kK0ga5ClHDEEpFsjOxfDLbO23wqUO/+EPgVSGRSWLZtlT+1IIsEjyyqdBAvzCIXIw/t2suIa2ggb/1awDVvLeScB9ohIhpLJA9N8eMj+C9HYtfYgIa9jaMePwABtRcXh7T9VaEfvhGJgRjWEmMCim9XN43EuFDplIu6xmH5Uc3D5Zizro5wFTPvDxk7+vLaSZ8Xc/x9hsjT5V4O3BhKGCoj2YlRMx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDrqRzoAfSrdMf3JdkuEtjA+IBdyeykngvJfTHqKRs4=;
 b=eGbNKiq2ZaGq3nfURlA2kM2bYUiZehk8rCp7T6yLuFzZSfvovVgmhfSzGTyDS7p/vqh8w7W/FrSeJIZ8EaeIjZ/ocg1rbQeMlePe27zK4rflUuHQ0IrwMtHA2itr7VAmanaGkKrrLRlUjyauHihG8gb1GQLRaqnX+nKiciOa44J30iW6SchqWX2ooKzc5BeygLybtHd3N7Z0SFqYQOqoMikjH6VxGUeNKUW//hs3Mq/xs8k4m8j9+gWVqDsDCWzM4WKCa4rv38sSlFGwibUJhn1UXCApqjxYbiZX/SYJd+quZDE2Xrq8dwp8xWHsy+BdR8FXG66aMPdsRkePZrPu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDrqRzoAfSrdMf3JdkuEtjA+IBdyeykngvJfTHqKRs4=;
 b=B2u9PcdR7V/dFuB++GWwIJiViytnEZRIdalkGbdXnETpwcz84mx5yhXzwAMs1uDne9UoAK+2gCgcLnysSmLRnbmKfHv54cnJts5Ihvndj3zSeF3sLUH+coTaWcB9gBZfatdMPL4Kj8nwRdo3r2lFHfKLvakEXUhSM1XX10Qu8Dg=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 06:26:55 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::3d7b:7e5b:458d:a32e]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::3d7b:7e5b:458d:a32e%6]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 06:26:55 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check save count before RAS bad page saving
Thread-Topic: [PATCH] drm/amdgpu: check save count before RAS bad page saving
Thread-Index: AQHcPk7TMtGfwgoN4kOeezZPn3CM5LTETxdg
Date: Thu, 16 Oct 2025 06:26:55 +0000
Message-ID: <MW4PR12MB68752B5C0DD02D8414ABFA2391E9A@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20251016034133.621266-1-tao.zhou1@amd.com>
In-Reply-To: <20251016034133.621266-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T06:26:49.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|DM4PR12MB6494:EE_
x-ms-office365-filtering-correlation-id: a0e3d696-68d9-4e61-748b-08de0c7d009a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?t3yqH4xVDxirLhbbipT+xjw6h2kF5Zq7kErjKjRshXJnqvlgrZJFfuWVkNnI?=
 =?us-ascii?Q?rK57kYNq6dNnmO6hhTsOMNLSbdpBj7Vh8adzn25lBY7RoTDh2EYxHaMqrJbN?=
 =?us-ascii?Q?FhABTlv1vv2Ie8xtQ37HtLCRDM+XMTq7zpkLD7nBrAVi3n3ThrBPJ0OmQDyl?=
 =?us-ascii?Q?XhTAywYayoJFxPApNMlkybMLQ2Ylm9txFK2NMhx2lkv/iMdzMwdUHi4k6q/k?=
 =?us-ascii?Q?osO0VpoiAWeQj3kseVNN/RjWff3pGvsB9B0oeLBnuRQUAaWAQ3xc+MCb8bc2?=
 =?us-ascii?Q?zODQ5A2QU2n9JBpd8TTOhPn2+PNDoGorK6G7LqsL+m2Gc6CZnEMXJA1mTzW1?=
 =?us-ascii?Q?TDFy3XTRFF2Ga/d0hPTxStyPYNO6ZCttkHmM0IP+1lJWRVkPqTKiilej5NMA?=
 =?us-ascii?Q?Hl2kymrBgRCEoNh1jHqjAIBins7Gk1cqQ+pfdeGS2kErY0BUQyJLqOxhX8g2?=
 =?us-ascii?Q?tOvji22uHsLb+FZ0w8Q8YhsUBvFcdHOy+x2NNYtRu/6ZF5m/q2KDdpkKo3vv?=
 =?us-ascii?Q?cguVVOYW8lCUSqvvbsPyWZuElnjZyCPd/hH3HJktB+9Y1FSY/GUIYe6e5HjJ?=
 =?us-ascii?Q?7rhlDXYGT0pj007PHbjsSMUPvep/38RbZK2rxND6Ygpg09BEsyQ9EaRndnvH?=
 =?us-ascii?Q?O95fOVeQOG2E1JDhoqTv8vyyhuEFFbH5TKZKL8KIEAV3lOkZsI2LJWJy+UBv?=
 =?us-ascii?Q?NgiMpqLy4ogxzKtQ84LNO2TTzqPdcacLzkFWrbuYtt7UWMZtEojc+JDrSQm9?=
 =?us-ascii?Q?9E3fQNmZ21A/Ol8p+muUvgLaLoQXOUi1U93dyZKsuG4nItn+o7TLdS/11H6S?=
 =?us-ascii?Q?VqGWaJgI3DtlBkfIEIp/xsjBaCUyKY+7HPbEmtiO3zw43XNUi7VShIg2JwKa?=
 =?us-ascii?Q?bYZ5VqA6TIzgWKH3B/Zc283pWwl2e3okcpV1n+BK3sO9Wm/LafcCbjQnonpc?=
 =?us-ascii?Q?FXDsR9eoyZgkZ87A66RXXKaJ7akPif6Xi/3tbKSH3aUxN8f7q9axZbg246HV?=
 =?us-ascii?Q?sG3W0bte8fZMHT8DMOX3N+QtHVL/q5CaFGRluK5ScuZrLDpX45YhkfH2daC8?=
 =?us-ascii?Q?MHdhJy2rzPR06Ku5gcdGziHzsOiaT+G2jPRdT7tQCSs3fF53ErXJlAlZQhJE?=
 =?us-ascii?Q?UEdZLKQ/w0rOUbQUkRMaq/x+xyPKQ95cuTDtpipDAL8VFB47Vd93mZUtBsHj?=
 =?us-ascii?Q?ms3RY+lUCMMC1i+fuxZKVacf4m8q9YLJHF7Q0D+rsWb63FVwyS74Kg+pa61R?=
 =?us-ascii?Q?8ZYqqzsQJnSDBq9uUUsBn3V17XH2zCkKGDW8DOfAvke5q4QIsdAnN025Ep9x?=
 =?us-ascii?Q?G/B9rQLe86M8RooLQPRKC+5w8euOHu7wFqeEsaodbEWfGQKZxaA1H7CRyZAm?=
 =?us-ascii?Q?UDA3+mUw0Sc8GIwy9/LiH9UADlEkiAug8fm8zuHkC9HJ+4vafU6ZfO8FlMQh?=
 =?us-ascii?Q?hViBbO/IDZN+jEIGi87U7dS2cptrfVvqxQFRHtChUhoT/u2ZM02YKgYoYMJX?=
 =?us-ascii?Q?QrL+mB4k9Fo2ESiaBaZ2CCcVS2Ac5y26OvKC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3JXDOYetH5VdYLUL+FD6NttNYqqTdHOwMzirb07ZV/jOhxpvFZtbs+RL1zPe?=
 =?us-ascii?Q?DkTm7hWvFqwTqp2WBO9XMKlIeWXVlTWp/UsVC0ySWVCHWBZrCfMz23Oc0I9u?=
 =?us-ascii?Q?zXrxs7t5FAbUbPfGJ1mFfVayzdsbOkiYS0DKrbOgPCGm31m8cYQGLapFvpbb?=
 =?us-ascii?Q?IwNYjjjUbkb9Fvy1A8zd54FRuR+wrFa9UPcCFbmBgaIDKlKeCV2wXPFdKGoH?=
 =?us-ascii?Q?dsWtEte1gl5oOROIL34itszVQdUCEkZUjlmkx5lI6WOPWipQtpKugZa3yLI5?=
 =?us-ascii?Q?T/WMLctJqUlx7TtzOfGsLHoIwiXycxJfeT9hl0ORVTUZHDVOjDa4KmNSPSie?=
 =?us-ascii?Q?UEIpMSuLTN1v/wpFsVE1c+ugRJ8oFYogg4uiqlHKDa7zz94J8+/IkDR4E66r?=
 =?us-ascii?Q?N0HQ9whj6eMg6P5qyCmsE0ddzf0eBmtoRPbTDFLhex9RPQ+59MA4vHjgSQW4?=
 =?us-ascii?Q?egvrT5gi75oOiOTctPEX/jbOFViNDdHR1g0bYFcL25CWE55rKhcE6USv8+bP?=
 =?us-ascii?Q?qmu3CnW4iDlU9wj+d1rvS83kxUM91lDM784AS7sDxT6utt5IO70iD0VvcG9z?=
 =?us-ascii?Q?bec+g2suddHM3jACbZJyf+nPPB3BLu4zXf22TiaVSyPI/aqHx+nkLCandL8j?=
 =?us-ascii?Q?jjwDTj5aI9ENXHPXIwSeP93f3AD5Th7F5mAn2A8mkqdC4NXkCCM0UVFeB7sE?=
 =?us-ascii?Q?NtmjrB/OnYCxGRyQiVe+nJO16mroFJsrJn7F6JXRaCP9kT+WCBOPfgdCSqma?=
 =?us-ascii?Q?4YT+Jsc0zWZjoDC5sceFo/YD1JSaUk+cP59kyN9W4BH5H+FOCl8DWkHRNcHd?=
 =?us-ascii?Q?5S8ZHqxPagA8tnCY+Ec0P8T8bZFC+fhS+A+sAvbuS4ve15nba751AKzatex4?=
 =?us-ascii?Q?8yPVU7nRjp3m+g23413iyhKXrje/SonZEhM80rjXa4YDgGPvWQCmAdpI06M/?=
 =?us-ascii?Q?FyKdgv2Q8NsWIh5TkQt7e7Z0YlZcq43M7LHsRPe/Uq59wFTQzJza4Z/0rBW4?=
 =?us-ascii?Q?NCKGQkblmGm+ChLalis3xSIo47x7zgljg59aSD/DaSP15G2a9ghNDPrWub46?=
 =?us-ascii?Q?PPSppkwPHcCIZUJ2g3xpqLQWQgBhMKMY/uHF376QTpyMU2sUzN3Sb28K8ppC?=
 =?us-ascii?Q?rYqFfvNbASTjGU9yyNlTHTNfkA6HafszFviw66eX+hpWIJgnEM3GmSZr6Dif?=
 =?us-ascii?Q?/nwo/TjiZ4I1lZXmYwGuLHmZw1yJuoukTMhqRkic3gkXlIXfsCHNLWYNvhIk?=
 =?us-ascii?Q?D+gzaBJsYoS3GocGfhUbq1hhpJV/jH3UOJN/MdyVFjfVgykTCMpNJ02bTG7V?=
 =?us-ascii?Q?eSwnHth+lUE9qrkxBO5Fv+WYgGiG4PoxtD07ljwzAx6wZuIm0vwy+ndNkz9m?=
 =?us-ascii?Q?TbPDZ1lpFkB8bBQeq8k9rGq7IM6XHloQkoHYOmkeY2IGVlzh/65EicBIcElU?=
 =?us-ascii?Q?72IJVIUArBY8rjzYmOCtNJaEg/0aEG+5zMts8d2m5GL14xXEwhhXyHAEyodc?=
 =?us-ascii?Q?qbursiQIK5ugloZnnDhKraGsLph7heKUQDRRzPxuIJvT9xAYuVIhdHrh1BPO?=
 =?us-ascii?Q?d1Vq1F3Ik0XD/ECFsOQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e3d696-68d9-4e61-748b-08de0c7d009a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:26:55.3267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXoq0+j96yQZmoAJzoxfnqMG5C0lNPUJCO6jeWhQMCByEO7r8i3ro3ZyRE7P70yQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Candice Li <candice.li@amd.com>


Thanks,
Candice

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, October 16, 2025 11:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: check save count before RAS bad page saving

It's possible that unit_num is larger than 0 but save_count is zero,
since we do get bad page address but the address is invalid. Check
unit_num and save_count together.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index c6f3a327108b..3b410ef49d91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3140,7 +3140,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *a=
dev,
                *new_cnt =3D unit_num;

        /* only new entries are saved */
-       if (unit_num > 0) {
+       if (unit_num && save_count) {
                /*old asics only save pa to eeprom like before*/
                if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < =
12) {
                        if (amdgpu_ras_eeprom_append(control,
--
2.34.1

