Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF04C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 11:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576A310E5A5;
	Mon, 30 May 2022 11:33:00 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2832B10E5A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 11:32:58 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UB7wdP027031;
 Mon, 30 May 2022 11:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=hmMg4BrZXzonubdUv3VFdMNmeqdejh4YN6VhJOUc9aU=;
 b=LW4AYhY8RZvc5C/SQXHeEa88bzHyPv+mP9ytfNVZG4zv1N9VDK0TLidYH6LDwssuXyRL
 t0cffiT5LSAo7vRffJQ6/crdsnAXj2hgUPKpNeBeqvdI4n9tmmM4TZ64LYgnCKdSYvfI
 NQZ6/AkjpE9l4Xec7G2Zda9ixalkWb6z9Hvvjrz8GLSVQeNRa5flktHyZi3TXdjNhIop
 UEBJWa50qtEi2InE1l9irtEdY6k6mztw24cfS6aS5DMzt2lt7uF6PMHqb6oTVUz62UiX
 pT2/5kmscoC2NcAbrDBdUml9Q53EjKw4k9dMXPgU9c7qbe8OeSlXj21rF+4kR0aj2Yuk bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm2hpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 May 2022 11:32:53 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24UBW2Zn034672; Mon, 30 May 2022 11:32:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3gc8hqnjxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 May 2022 11:32:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hbt6v/4oiCft9Nj2CX2ZtRuT3bORKu39UKpbrGUBzoiYfkiw6dKMSulyBJqU7ZEXPSqq37Tjchq+T3ZfpJSFkjNHtBoGS5IhpiN766PFk45o7EWagDx9fk5Q7ZkXS3VCsCpMzc6E21qRmepiQWGfz5eyb8aYOoNcBG0gDuOkEmZ3IkdM6QauTT4KUrZoulV55bjLLkjwlS6YVXs4Hcsp4FTbDvBZDIurKJU3TTbYGnU5l77/T9hmYG28yiC29dkammTd2843+f3Dvw+oLATt5EsuioLtDcqLEFYoTBgLTi3eGNr7cLzIFnvldO0zIqPNKmmGq5sHIVqOAHxW4cKSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmMg4BrZXzonubdUv3VFdMNmeqdejh4YN6VhJOUc9aU=;
 b=XNMplc+bf6j9w4HPVzsQv7se3IUKQyXDXt5zCPBQLbFDA97SyviGxMfAIY3Nfe1foth2RRaAVdBmyZv8D05J0symVHtJPJXM8mDxvHk8IL7IQ/f+FwPOin0NsroUugBD4M3p0DLQwbbQkgkdyb0nCO14XLosdptKhuuth9bxRrnKA2H/zQHHz2AQcTa1Lc+R+53cnEYLRJFNFVYubRhSbhxK1DghUtXGOVc/RjwpoND6qiFmKdrvY1PB9AT/4iK8unurRpOGwKOj1fO6VsPdB0oklAnYnTWbrSViM28AWRisudUQV+4MKqPQWVItImF0lj4l84BbVFsG5tx8Efk38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmMg4BrZXzonubdUv3VFdMNmeqdejh4YN6VhJOUc9aU=;
 b=SyRLGpOfL3LubYaIBiF52LUwsh7ROb2HwvTEG6hEgGLQOd4zGaMoviQQgkRXTqGwTEwKQ2lf3DKs9e8mkXln8QYLrH4Ft+qzvhu1a/dB+uzlcNHCvvGP6Uy2lPFR2WyV65blr10MALlReYsa5mSEiih4fmpMLwizcloDMTERYRs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4648.namprd10.prod.outlook.com
 (2603:10b6:510:30::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 11:32:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 11:32:49 +0000
Date: Mon, 30 May 2022 14:32:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: alexander.deucher@amd.com
Subject: [bug report] drm/radeon: add dpm support for CI dGPUs (v2)
Message-ID: <YpSrWCnQ2wGrFtNe@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6124b6e1-4b6e-4313-037e-08da42302033
X-MS-TrafficTypeDiagnostic: PH0PR10MB4648:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4648ABF9DE2FDDD6BCF90F018EDD9@PH0PR10MB4648.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kI6EEy4EQP+e6qRWgS5hAqRYFMHBH2rEac/c3DCO115Ed3V2pAMi97sV1TMb8dzwx79UzSE1Mxo80ww4YEuAtYex6i3kKoDHygbOHqCxiji+1bhGMVP8GiDhNHjSCKjFKo7j6c4gIVK6E6+P9WZe/mNWCM/RV9Mu88VlSAGDBKFYY4GD9XU9scq6ShE+MmaFSIOjQHHZ3SQAFhv40OlzlLHE2PmHWVISQjfU4SoNDvfUMoj3pZRPrbgjRhW7tNNlqqdqJegbtvomlrzh+xgGzRMvEMFlUszqlCJGtPK2hmESD+bEM4HBGIH8pVmyJkvvZalW8knwoCH6Yc6xd3OaKuGDTI8R0k+K5d3pUS1uhEpBdx7cd3IGRPFwzDqBMO1j4HkVOHpLQEOofnGvwp0Mk8TUKPs4LbFxOxQrRSELdzS3T61gGxFl0fmIXhZOZwmfTbazRKH82QI3mEzU6BTfOBpzQiVKe4zbLWhNCDgFzL6MgpKSjcfXr6gNrqRY8lHgu73MVn2MRjxgXPh5a4RjtI5n/yH59l0wzAgBe9mX7hdhlQlHfU6W4PdRcgZN6QuzIefX1sfCqa/0PiOlLjjohTHLxQ+X08JkJDPAmp/tTBENJpxZCJTBNkyoj9ZjgKCT9FfdisFAGFDnL28vmjRkeTVWKfgOvUnwDjlBdJk9OgFxhf8+I+0ctjXPZ2d2IgtxnfQLqueDZa/VTJYVWaqfKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(6512007)(26005)(6506007)(9686003)(6916009)(316002)(6666004)(8676002)(5660300002)(44832011)(8936002)(6486002)(52116002)(19627235002)(66946007)(66476007)(186003)(66556008)(508600001)(2906002)(38100700002)(86362001)(33716001)(38350700002)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgDtA5GFbdJmyUfamzkfPEb7HRTT4ljbRPMioNFrg8RUGOYU3OSBF9ldpq9i?=
 =?us-ascii?Q?3coxfbqmkNfMMoKj0QS5Q9bZpdhBRGBVQX6s6O7iMIDtqGzWirAMPhx6twBH?=
 =?us-ascii?Q?GoN8N/IPnlcDO64D6FO1ks1wRES6Bf3bGfvtD5jGFi/iSloraxfLVWIT49Om?=
 =?us-ascii?Q?avvbYTihNFCVp6ccNOhtrvYBIj49E7tBj5/yRUFmqCxBguDsQygUE/W648L1?=
 =?us-ascii?Q?doJJSIJzrYbWxaQ1UIM2JezY++aJ5jRqMspgeTC5x1iBn7XBRpw+H+1xOPcF?=
 =?us-ascii?Q?H2gUZ/X2oB6ZI+EVr8QtoEbbYN5u9XNkFAxSt8tBijGFMsGbnO7lfTPybBqD?=
 =?us-ascii?Q?e3g5QCybPfNtII4SRrrJKzK4sSBuBQE8hZ3MpsnHi8bDgqZyc2HbYZAoC/mX?=
 =?us-ascii?Q?xKKMkbyjlFVbTJjvHJ8+0hkENXlcQR5yLoLLMf9mXPRpWgkg1MDaogooNj+J?=
 =?us-ascii?Q?/aj/f0fBLULBh/XYtDhOAGsPrNZtWEeu5+1hWyRYS5mbkz8m9OXUBp7Cjyyb?=
 =?us-ascii?Q?MFDfpJ45FuGnGTcoYohROLo1tKFhlXYv5GkCcEjTLfKP5Ws6KlR95fVc1qq/?=
 =?us-ascii?Q?A23X2ySONRGp4C7jvMmHvO3XsNFd02NKIPKoMfEsr94DRB58MV0TsqKubURO?=
 =?us-ascii?Q?cWthw7uzjapMee+zbyiemZ7PfP3Ci0C7NVCWN3qFeODHX+2P75nt5hCUqUR+?=
 =?us-ascii?Q?gpqj7KzXaaDjA72BpJ0LvWbmWBDPQUlIIe9uXS+sTYmj5pcJj2YCxZ4QboFf?=
 =?us-ascii?Q?Q+kygbJMEiElWO7AN0c8RI84Yw2VB/eLlID7OilHWGA0xTdlbYzKKRxlcv43?=
 =?us-ascii?Q?ur/S6c73EVVAvbNvEeLprUvRdXlmb72CmgXRfy/fbhZzDh+kGcSmREUbqLaN?=
 =?us-ascii?Q?ZA0b2n2DfFrXwfcX6fUXrp47e7mc75rlH1CX372OE+kEVrsm77N/5ePREXow?=
 =?us-ascii?Q?9uO/NgvpxC8y2YU85WMhIo5zM1Lf0F1PE7E/7atRvVJW/PavREWqGf3nbPjL?=
 =?us-ascii?Q?LuzOTwT/FBMyn4s0/HguNulXkudsml6Y/ZhDIe/yCjXYL+8t0MdF2ar8oWrK?=
 =?us-ascii?Q?MXdScZG24H2vQk74HRMLdZJpnoWaGAzVrE14lm8I2VzvTuc4fl6Kt0WG5crC?=
 =?us-ascii?Q?VuAAIUHAzt4rzO5Sl/0X5La6t8ACbZ4ePw+B3uSTqk1GUckebzimLz7TPQNA?=
 =?us-ascii?Q?GKws7ThG/GZYh/1gVlZvnBC//Z63GK71t/73Io1Al6K2eKOaAxwgBF730Ojq?=
 =?us-ascii?Q?AmT9Yo2TJP3C5YAW5pec3agAviuSt7K9q+LNzRzPBhvEPG765N6e8xfXaCHb?=
 =?us-ascii?Q?uwAvH6pwcdyvg+iWtm0l3mcaocxd41lOvm0gSR7qzKdXty1TG5D8MLcpKjop?=
 =?us-ascii?Q?We8hRpm/2YBdteEKTSlK+9yM7yHU9zCGim/NEyN/BWrvnk9s9iFV0pElhuTn?=
 =?us-ascii?Q?P73QfdZJ0HSaPcCjfBxNsDM/jrn1IiN4oN/fvW/8qtnX4zCyrzqX7bWEzUn1?=
 =?us-ascii?Q?Vhpu9j5u8TH8SE6wqdAFHZJEQMJzyBa10fOLW+pH6mrM7Lf3/NbEHmB8cHGj?=
 =?us-ascii?Q?lM9Y5oS45+ZcmeK6Sq9jJiaWpM3AgrZ0NPnEzPwdKnTYF7gbocLzEQwsM1Wo?=
 =?us-ascii?Q?xaVW516tJ0c4Qy32UPbjOeKbyBn479fisAyT0i2ZnHnP3X6HOHSQGpOqf5ht?=
 =?us-ascii?Q?9nrPgLubCU31H/AJMXsFDq9tZVF+aSWaJwSqKPGUZvzOHymu7bA3Ry/eLVyB?=
 =?us-ascii?Q?1Dxc3RqFEAM76owKq4GN/jWW206P93c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6124b6e1-4b6e-4313-037e-08da42302033
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 11:32:49.3986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjZ8Co/FH+gzRVyjyJxojoDvbDzaZGCiBnAINP7X+Jjp0wr9mtqK5RDW+hOShYIwSQ5NHnWR5T/SN9Go27sKItEhZN9M9nO0p/G19ZeewtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4648
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-30_04:2022-05-30,
 2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300060
X-Proofpoint-GUID: WVQAtVTCIVFuRYVyhsBUdzSStFIBG3ej
X-Proofpoint-ORIG-GUID: WVQAtVTCIVFuRYVyhsBUdzSStFIBG3ej
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[ Ancient code.  No idea why it's only being reported as a bug now.  -dan ]

Hello Alex Deucher,

The patch cc8dbbb4f62a: "drm/radeon: add dpm support for CI dGPUs
(v2)" from Aug 14, 2013, leads to the following Smatch static checker
warning:

drivers/gpu/drm/radeon/ci_dpm.c:5695 ci_dpm_init() warn: 'rdev->pm.dpm.dyn_state.cac_leakage_table.entries' double freed
drivers/gpu/drm/radeon/ci_dpm.c:5695 ci_dpm_init() warn: 'rdev->pm.dpm.dyn_state.cac_tdp_table' double freed
drivers/gpu/drm/radeon/ci_dpm.c:5695 ci_dpm_init() warn: 'rdev->pm.dpm.dyn_state.ppm_table' double freed

drivers/gpu/drm/radeon/ci_dpm.c
    5637 int ci_dpm_init(struct radeon_device *rdev)
    5638 {
    5639         int index = GetIndexIntoMasterTable(DATA, ASIC_InternalSS_Info);
    5640         SMU7_Discrete_DpmTable  *dpm_table;
    5641         struct radeon_gpio_rec gpio;
    5642         u16 data_offset, size;
    5643         u8 frev, crev;
    5644         struct ci_power_info *pi;
    5645         enum pci_bus_speed speed_cap = PCI_SPEED_UNKNOWN;
    5646         struct pci_dev *root = rdev->pdev->bus->self;
    5647         int ret;
    5648 
    5649         pi = kzalloc(sizeof(struct ci_power_info), GFP_KERNEL);
    5650         if (pi == NULL)
    5651                 return -ENOMEM;
    5652         rdev->pm.dpm.priv = pi;
    5653 
    5654         if (!pci_is_root_bus(rdev->pdev->bus))
    5655                 speed_cap = pcie_get_speed_cap(root);
    5656         if (speed_cap == PCI_SPEED_UNKNOWN) {
    5657                 pi->sys_pcie_mask = 0;
    5658         } else {
    5659                 if (speed_cap == PCIE_SPEED_8_0GT)
    5660                         pi->sys_pcie_mask = RADEON_PCIE_SPEED_25 |
    5661                                 RADEON_PCIE_SPEED_50 |
    5662                                 RADEON_PCIE_SPEED_80;
    5663                 else if (speed_cap == PCIE_SPEED_5_0GT)
    5664                         pi->sys_pcie_mask = RADEON_PCIE_SPEED_25 |
    5665                                 RADEON_PCIE_SPEED_50;
    5666                 else
    5667                         pi->sys_pcie_mask = RADEON_PCIE_SPEED_25;
    5668         }
    5669         pi->force_pcie_gen = RADEON_PCIE_GEN_INVALID;
    5670 
    5671         pi->pcie_gen_performance.max = RADEON_PCIE_GEN1;
    5672         pi->pcie_gen_performance.min = RADEON_PCIE_GEN3;
    5673         pi->pcie_gen_powersaving.max = RADEON_PCIE_GEN1;
    5674         pi->pcie_gen_powersaving.min = RADEON_PCIE_GEN3;
    5675 
    5676         pi->pcie_lane_performance.max = 0;
    5677         pi->pcie_lane_performance.min = 16;
    5678         pi->pcie_lane_powersaving.max = 0;
    5679         pi->pcie_lane_powersaving.min = 16;
    5680 
    5681         ret = ci_get_vbios_boot_values(rdev, &pi->vbios_boot_state);
    5682         if (ret) {
    5683                 ci_dpm_fini(rdev);
    5684                 return ret;
    5685         }
    5686 
    5687         ret = r600_get_platform_caps(rdev);
    5688         if (ret) {
    5689                 ci_dpm_fini(rdev);
    5690                 return ret;
    5691         }
    5692 
    5693         ret = r600_parse_extended_power_table(rdev);
    5694         if (ret) {i
--> 5695                 ci_dpm_fini(rdev);

rdev->pm.dpm.dyn_state.cac_leakage_table.entries is freed
on error inside r600_parse_extended_power_table() and again inside
ci_dpm_fini().

    5696                 return ret;
    5697         }
    5698 
    5699         ret = ci_parse_power_table(rdev);
    5700         if (ret) {
    5701                 ci_dpm_fini(rdev);

regards,
dan carpenter
